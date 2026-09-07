#!/usr/bin/env python3
"""Manage one private Docker Compose stack for live SDK verification."""

from __future__ import annotations

import argparse
import base64
import hashlib
import hmac
import json
import os
import re
import secrets
import shlex
import shutil
import socket
import stat
import subprocess
import sys
import tempfile
import time
import uuid
from pathlib import Path
from typing import Any
from urllib.parse import urlsplit, urlunsplit

import httpx

from xberg_io_sdk import XbergClient

ROOT = Path(__file__).resolve().parents[1]
STATE_VERSION = 1
RUNTIME_USER = "65532:65532"
STARTUP_TIMEOUT_SECONDS = 240
ROLE_NAMES = (
    "ADMIN",
    "APPLICATION",
    "MAINTENANCE",
    "INDEX_WORKER",
    "VECTOR_BROKER",
    "SCHEMA_OWNER",
    "ROLE_ADMIN",
    "MIGRATION",
    "PHYSICAL_MIGRATION",
)
PORT_NAMES = ("api", "backend", "postgres", "nats", "nats_metrics", "gcs", "broker_metrics", "worker_metrics")


def private_directory(path: Path) -> None:
    """Create an owner-only state directory without following its final symlink."""
    if path.is_symlink():
        raise ValueError("refusing symlinked state directory")
    path.mkdir(mode=0o700, parents=True, exist_ok=True)
    info = path.stat()
    if not stat.S_ISDIR(info.st_mode) or info.st_uid != os.getuid():
        raise ValueError("state directory must belong to the current user")
    path.chmod(0o700)


def write_private(path: Path, value: Any) -> None:
    """Atomically replace a private JSON artifact without exposing partial credentials."""
    descriptor, temporary = tempfile.mkstemp(prefix=".state-", dir=path.parent)
    try:
        with os.fdopen(descriptor, "w") as output:
            json.dump(value, output, indent=2)
            output.write("\n")
        Path(temporary).replace(path)
    finally:
        if Path(temporary).exists():
            Path(temporary).unlink()


def reserve_port_numbers() -> dict[str, int]:
    """Allocate distinct currently unused loopback ports for this stack."""
    sockets = []
    try:
        for _ in PORT_NAMES:
            connection = socket.socket()
            connection.bind(("127.0.0.1", 0))
            sockets.append(connection)
        return dict(zip(PORT_NAMES, [connection.getsockname()[1] for connection in sockets], strict=True))
    finally:
        for connection in sockets:
            connection.close()


def validate_state(state: dict[str, Any], tier: str) -> None:
    """Reject state that does not identify this user and exact managed Compose scope."""
    instance = state.get("instance", "")
    if not re.fullmatch("[0-9a-f]{32}", instance) or state.get("project") != f"xberg-sdk-{tier}-{instance}":
        raise ValueError("refusing unrecognized Compose scope")
    if state.get("version") != STATE_VERSION or state.get("uid") != os.getuid() or state.get("tier") != tier:
        raise ValueError("state version, owner, or tier differs from this invocation")


def read_state(directory: Path, tier: str) -> dict[str, Any]:
    """Load a private persisted stack identity and validate its owner and tier."""
    private_directory(directory)
    path = directory / "state.json"
    if path.is_symlink() or stat.S_IMODE(path.stat().st_mode) != 0o600 or path.stat().st_uid != os.getuid():
        raise ValueError("state.json must be a private file owned by the current user")
    state = json.loads(path.read_text())
    validate_state(state, tier)
    return state


def initialize_state(directory: Path, tier: str) -> dict[str, Any]:
    """Create persistent random credentials and an isolated Compose identity."""
    if directory.is_symlink():
        raise ValueError("refusing symlinked state directory")
    if directory.exists() and any(directory.iterdir()):
        if (directory / "state.json").exists():
            return read_state(directory, tier)
        raise ValueError("refusing unrecognized files in state directory")
    private_directory(directory)
    instance = uuid.uuid4().hex
    state = {
        "version": STATE_VERSION,
        "uid": os.getuid(),
        "tier": tier,
        "instance": instance,
        "project": f"xberg-sdk-{tier}-{instance}",
        "ports": reserve_port_numbers(),
        "jwt_secret": secrets.token_urlsafe(48),
        "admin_key": "kz_admin_" + secrets.token_hex(32),
        "passwords": {name: secrets.token_urlsafe(32) for name in ROLE_NAMES},
        "nats_passwords": {
            name: "sdk_" + secrets.token_urlsafe(32)
            for name in ("api", "worker", "backend", "billing", "rag", "webhook")
        },
    }
    write_private(directory / "state.json", state)
    return state


def container_database_url(value: str) -> str:
    """Translate a host development database URL onto the owned Compose network."""
    parsed = urlsplit(value)
    authority = parsed.netloc.rsplit("@", 1)[0]
    return urlunsplit(parsed._replace(netloc=authority + "@postgres:5432"))


def published_port(target: int, port: int) -> dict[str, Any]:
    """Publish one service port exclusively on host loopback."""
    return {"target": target, "published": str(port), "host_ip": "127.0.0.1", "protocol": "tcp"}


def runtime_service(binary: str, directory: Path, image: str, environment: dict[str, str]) -> dict[str, Any]:
    """Describe a restricted runtime using read-only verified binary mounts."""
    return {
        "image": image,
        "pull_policy": "never",
        "entrypoint": [f"/app/{binary}"],
        "user": RUNTIME_USER,
        "read_only": True,
        "init": True,
        "cap_drop": ["ALL"],
        "security_opt": ["no-new-privileges:true"],
        "tmpfs": ["/tmp:rw,nosuid,nodev,size=256m"],  # noqa: S108 ~keep Container-private tmpfs, not host temporary state.
        "environment": environment,
        "volumes": [{"type": "bind", "source": str(directory), "target": "/app", "read_only": True}],
        "depends_on": {"sdk-runtime-init": {"condition": "service_completed_successfully"}},
    }


def runtime_services(state: dict[str, Any], environment: dict[str, str], directory: Path, image: str) -> dict[str, Any]:
    """Wire the API, backend, workers and credential-isolated broker containers."""
    storage = {
        "STORAGE_PROVIDER": "gcs",
        "STORAGE_BUCKET": "sdk-live-uploads",
        "GCS_ENDPOINT": "http://gcs-emulator:4443",
        "STORAGE_ENDPOINT_ALLOWLIST": "gcs-emulator,localhost,127.0.0.1",
        "STORAGE_EMULATOR_HOST": "http://gcs-emulator:4443",
        "CACHE_DIR": "/tmp/cache",  # noqa: S108 ~keep Cache lives inside the container-private tmpfs.
        "CACHE_ENABLED": "false",
    }
    common = {key: container_database_url(environment[key]) for key in ("DATABASE_URL", "MAINTENANCE_DATABASE_URL")}
    common.update(
        {
            "DATABASE_TLS_ENABLED": "false",
            "JWT_SECRET": state["jwt_secret"],
            "NATS_URL": "nats://nats:4222",
            "RUST_LOG": "info",
        }
    )
    services = {}
    for name in ("api", "backend", "worker", "rag"):
        config = {**common, "NATS_USER": name, "NATS_PASSWORD": state["nats_passwords"][name]}
        if name != "backend":
            config.update(storage)
        services["sdk-" + name] = runtime_service(name, directory, image, config)
    services["sdk-api"]["environment"].update({"REST_ADDR": "0.0.0.0:8081", "METRICS_ADDR": "0.0.0.0:9091"})
    services["sdk-api"]["ports"] = [published_port(8081, state["ports"]["api"])]
    services["sdk-backend"]["environment"].update(
        {
            "SERVER_PORT": "8080",
            "AUTH_ENABLED": "false",
            "STRIPE_SECRET_KEY": "sk_test_sdk_local_non_billing",
            "STRIPE_STANDARD_PRICE_ID": "price_sdk_local_non_billing",
            "FRONTEND_BASE_URL": "http://127.0.0.1",
            "SANDBOX_API_URL": "http://sdk-api:8081",
            "SANDBOX_PUBLIC_AUTH_MODE": "disabled",
        }
    )
    services["sdk-backend"]["ports"] = [published_port(8080, state["ports"]["backend"])]
    services["sdk-rag"]["environment"].update({"METRICS_ADDR": "0.0.0.0:9093", "NO_PROXY": "*", "no_proxy": "*"})
    services["sdk-worker"]["environment"].update({"METRICS_ADDR": "0.0.0.0:9092", "NO_PROXY": "*", "no_proxy": "*"})
    broker = {
        key: container_database_url(environment[key])
        for key in ("VECTOR_INDEX_BROKER_DATABASE_URL", "VECTOR_INDEX_QUEUE_DATABASE_URL")
    }
    broker.update(
        {
            "VECTOR_INDEX_BROKER_BINARY": "/app/vector-index-broker",
            "VECTOR_INDEX_BROKER_SOCKET_ACCESS": "owner-only",
            "VECTOR_INDEX_WORKER_LOGIN": "xberg_index_worker_login",
            "VECTOR_INDEX_MIGRATION_LOGIN": "xberg_schema_migrator",
            "VECTOR_INDEX_BROKER_LOGIN": "xberg_vector_index_broker_login",
            "VECTOR_INDEX_PHYSICAL_MIGRATION_LOGIN": "xberg_physical_migration_login",
            "METRICS_ADDR": "0.0.0.0:9097",
            "DATABASE_TLS_ENABLED": "false",
        }
    )
    for service, binary, config in (
        ("sdk-vector-broker", "vector-index-broker-launcher", broker),
        ("sdk-vector-worker", "vector-index-worker", {"METRICS_ADDR": "0.0.0.0:9096"}),
    ):
        config.update({"VECTOR_INDEX_BROKER_SOCKET": "/broker/runtime/broker.sock", "RUST_LOG": "info"})
        services[service] = runtime_service(binary, directory, image, config)
        services[service]["volumes"].append({"type": "volume", "source": "sdk-broker", "target": "/broker"})
    services["sdk-vector-broker"]["ports"] = [published_port(9097, state["ports"]["broker_metrics"])]
    services["sdk-vector-worker"]["ports"] = [published_port(9096, state["ports"]["worker_metrics"])]
    services["sdk-runtime-init"] = {
        "image": image,
        "pull_policy": "never",
        "user": "0:0",
        "network_mode": "none",
        "read_only": True,
        "entrypoint": ["/bin/sh", "-c", "chown 65532:65532 /broker"],
        "cap_drop": ["ALL"],
        "cap_add": ["CHOWN"],
        "volumes": [{"type": "volume", "source": "sdk-broker", "target": "/broker"}],
    }
    return services


def run(command: list[str], directory: Path, environment: dict[str, str], *, capture: bool = False) -> str:
    """Run a scoped command, retaining failures only in private diagnostics."""
    result = subprocess.run(command, cwd=directory, env=environment, capture_output=True, text=True, check=False)  # noqa: S603
    if result.returncode:
        diagnostics = Path(environment["TMPDIR"]).parent / "last-command.json"
        write_private(diagnostics, {"command": command, "stdout": result.stdout, "stderr": result.stderr})
        raise RuntimeError(f"{Path(command[0]).name} failed with exit {result.returncode}; inspect scoped Docker logs")
    return result.stdout if capture else ""


def base_environment(directory: Path, state: dict[str, Any]) -> dict[str, str]:
    """Keep Docker access settings and generate only stack-specific service credentials."""
    environment = {
        key: value
        for key, value in os.environ.items()
        if key in {"PATH", "HOME", "DOCKER_HOST", "DOCKER_CONTEXT", "DOCKER_CONFIG"}
    }
    temporary = directory / "temporary"
    private_directory(temporary)
    environment.update(
        {
            "TMPDIR": str(temporary),
            "COMPOSE_PROJECT_NAME": state["project"],
            "LOCAL_POSTGRES_PORT": str(state["ports"]["postgres"]),
            "LOCAL_POSTGRES_IMAGE": os.environ.get("LOCAL_POSTGRES_IMAGE", "pgvector/pgvector:pg18"),
        }
    )
    environment.update({f"PRO_POSTGRES_{role}_PASSWORD": value for role, value in state["passwords"].items()})
    environment.update({f"NATS_{role.upper()}_PASSWORD": value for role, value in state["nats_passwords"].items()})
    environment["XBERG_ADMIN_KEY"] = state["admin_key"]
    return environment


def parse_exports(text: str) -> dict[str, str]:
    """Parse credential assignments without executing shell output."""
    result = {}
    for line in text.splitlines():
        tokens = shlex.split(line)
        if tokens and tokens[0] == "export":
            tokens = tokens[1:]
        if len(tokens) != 1 or "=" not in tokens[0]:
            raise ValueError("unexpected credential environment output")
        key, value = tokens[0].split("=", 1)
        if not re.fullmatch("[A-Z][A-Z0-9_]*", key):
            raise ValueError("invalid environment variable name")
        result[key] = value
    return result


def compose_command(directory: Path, state: dict[str, Any], *arguments: str) -> list[str]:
    """Build a Docker command pinned to the validated project and private configuration."""
    validate_state(state, state["tier"])
    return [
        "docker",
        "compose",
        "--env-file",
        "/dev/null",
        "--project-name",
        state["project"],
        "--file",
        str(directory / "compose.json"),
        *arguments,
    ]


def configure(directory: Path, state: dict[str, Any], enterprise: Path) -> dict[str, str]:
    """Render the sibling shipping Compose configuration into private stack state."""
    environment = base_environment(directory, state)
    filename = "docker-compose.pro.yml" if state["tier"] == "pro" else "docker-compose.yml"
    if state["tier"] == "enterprise":
        environment.update(
            parse_exports(run([str(enterprise / "scripts/local-db-env.sh")], enterprise, environment, capture=True))
        )
    else:
        image = os.environ.get("PRO_IMAGE")
        if not image:
            raise ValueError("PRO_IMAGE must name a built shipping Pro image")
        environment.update({"PRO_IMAGE": image, "PRO_PULL_POLICY": "never"})
    rendered = run(
        [
            "docker",
            "compose",
            "--env-file",
            "/dev/null",
            "--project-name",
            state["project"],
            "--profile",
            "bootstrap",
            "--file",
            str(enterprise / filename),
            "config",
            "--format",
            "json",
        ],
        enterprise,
        environment,
        capture=True,
    )
    config = json.loads(rendered)
    if state["tier"] == "enterprise":
        configure_enterprise(config, state, environment)
    else:
        pro = config["services"]["pro"]
        pro.pop("build", None)
        pro["ports"] = [published_port(8080, state["ports"]["api"])]
        license_path = Path(os.environ["XBERG_PRO_LICENSE_FILE"])
        pro["environment"].update(parse_exports(license_path.read_text()))
        pro["environment"].update(
            {
                "XBERG_ADMIN_KEY": state["admin_key"],
                "JWT_SECRET": state["jwt_secret"],
                "XBERG_RAG_WARMUP_ENABLED": "false",
            }
        )
    write_private(directory / "compose.json", config)
    state["enterprise_directory"] = str(enterprise)
    state["api_url"] = f"http://127.0.0.1:{state['ports']['api']}"
    state["control_plane_url"] = (
        state["api_url"] if state["tier"] == "pro" else f"http://127.0.0.1:{state['ports']['backend']}"
    )
    write_private(directory / "state.json", state)
    environment["COMPOSE_FILE"] = str(directory / "compose.json")
    return environment


def gcs_signing_credential() -> str:
    """Generate an ephemeral signing identity for the owned GCS emulator."""
    executable = shutil.which("openssl")
    if executable is None:
        raise RuntimeError("openssl is required for ephemeral GCS signing")
    generated = subprocess.run(  # noqa: S603
        [executable, "genpkey", "-algorithm", "RSA", "-pkeyopt", "rsa_keygen_bits:2048"],
        capture_output=True,
        check=False,
        timeout=30,
    )
    if generated.returncode:
        raise RuntimeError("ephemeral GCS signing key generation failed")
    credential = {
        "type": "service_account",
        "client_email": "sdk-live@fixture.invalid",
        "private_key": generated.stdout.decode(),
    }
    return base64.b64encode(json.dumps(credential).encode()).decode()


def configure_enterprise(config: dict[str, Any], state: dict[str, Any], environment: dict[str, str]) -> None:
    """Add built Enterprise services and isolated host ports to the sibling infrastructure."""
    binary_directory = Path(os.environ.get("XBERG_ENTERPRISE_BINARY_DIR", "")).resolve()
    image = os.environ.get("XBERG_ENTERPRISE_RUNTIME_IMAGE", "")
    required = (
        "api",
        "backend",
        "worker",
        "rag",
        "vector-index-broker",
        "vector-index-broker-launcher",
        "vector-index-worker",
    )
    if not image or any(not (binary_directory / binary).is_file() for binary in required):
        raise ValueError(
            "XBERG_ENTERPRISE_RUNTIME_IMAGE and XBERG_ENTERPRISE_BINARY_DIR must identify built Linux services"
        )
    ports = state["ports"]
    services = config["services"]
    services["postgres"]["ports"] = [published_port(5432, ports["postgres"])]
    services["nats"]["ports"] = [published_port(4222, ports["nats"]), published_port(8222, ports["nats_metrics"])]
    services["gcs-emulator"]["ports"] = [published_port(4443, ports["gcs"])]
    services["gcs-emulator"]["command"] = [
        "-scheme",
        "http",
        "-port",
        "4443",
        "-backend",
        "filesystem",
        "-filesystem-root",
        "/storage",
        "-public-host",
        "gcs-emulator:4443",
        "-external-url",
        f"http://127.0.0.1:{ports['gcs']}",
    ]
    services.update(runtime_services(state, environment, binary_directory, image))
    if not state.get("gcs_credential"):
        state["gcs_credential"] = gcs_signing_credential()
    services["sdk-api"]["environment"]["GCS_CREDENTIAL"] = state["gcs_credential"]
    config.setdefault("volumes", {})["sdk-broker"] = {}
    state["upload_runtime_image"] = image
    state["upload_network"] = config["networks"]["default"]["name"]


def wait_ready(url: str) -> None:
    """Require a live readiness response within a bounded startup deadline."""
    deadline = time.monotonic() + STARTUP_TIMEOUT_SECONDS
    with httpx.Client(timeout=3, trust_env=False) as client:
        while time.monotonic() < deadline:
            try:
                response = client.get(url)
                if response.status_code == 200:
                    return
            except httpx.HTTPError:
                pass
            time.sleep(1)
    raise RuntimeError("service readiness deadline exceeded; inspect scoped Docker logs")


def session_token(state: dict[str, Any]) -> str:
    """Mint a local fixture identity accepted only by this stack's random JWT secret."""
    now = int(time.time())

    def encode(value: Any) -> str:
        return base64.urlsafe_b64encode(json.dumps(value, separators=(",", ":")).encode()).rstrip(b"=").decode()

    header = encode({"alg": "HS256", "typ": "JWT"})
    claims = encode(
        {
            "iss": "xberg",
            "aud": "xberg-services",
            "sub": "sdk-" + state["instance"],
            "project_id": str(uuid.UUID(int=0)),
            "role": "OWNER",
            "iat": now,
            "exp": now + 86400,
            "email": "sdk@xberg.io",
        }
    )
    body = header + "." + claims
    signature = hmac.new(state["jwt_secret"].encode(), body.encode(), hashlib.sha256).digest()
    return body + "." + base64.urlsafe_b64encode(signature).rstrip(b"=").decode()


def mint_fixture(directory: Path, state: dict[str, Any]) -> None:
    """Create a real project and write-scoped API key through the SDK."""
    if state.get("api_key"):
        return
    token = state["admin_key"] if state["tier"] == "pro" else session_token(state)
    with XbergClient(
        base_url=state["api_url"],
        control_plane_base_url=state["control_plane_url"],
        api_key=token,
        control_plane_token=token,
        target=state["tier"],
    ) as client:
        if state["tier"] == "pro":
            project = client.create_project({"name": "SDK live contract", "slug": "sdk-" + state["instance"]})
            key = client.create_api_key(str(project.id), {"name": "SDK live contract", "scope": "write"})
        else:
            project = client.backend_create_project({"name": "SDK live contract " + state["instance"]})
            key = client.backend_create_api_key(str(project.id), {"name": "SDK live contract", "scope": "write"})
    state.update(
        {"api_key": key.key, "project_id": str(project.id), "key_id": str(key.id), "control_plane_token": token}
    )
    write_private(directory / "state.json", state)


def crawl_fixture_sql(project_id: str, crawl_id: str) -> str:
    """Seed only a terminal row for real idle SSE tests; no crawl work is queued."""
    project_id, crawl_id = str(uuid.UUID(project_id)), str(uuid.UUID(crawl_id))
    # ~keep Both SQL values are canonical UUIDs, validated above before interpolation.
    return f"""BEGIN;
SET LOCAL app.current_project_id = '{project_id}';
INSERT INTO crawl_jobs (id, project_id, seed_urls, status, crawl_config, metadata, started_at, completed_at)
VALUES ('{crawl_id}', '{project_id}', ARRAY[]::text[], 'COMPLETED', '{{}}',
        '{{"fixture":"sdk-idle-cancellation"}}', now(), now());
SELECT id FROM crawl_jobs WHERE id = '{crawl_id}' AND project_id = '{project_id}' AND status = 'COMPLETED';
COMMIT;
"""  # noqa: S608


def prepare_idle_crawl(directory: Path, state: dict[str, Any], enterprise: Path) -> None:
    """Create a project-scoped terminal fixture and verify the real authenticated SSE endpoint."""
    if state["tier"] != "enterprise" or not state.get("api_key"):
        raise ValueError("idle crawl fixture requires a ready Enterprise stack")
    if not state.get("crawl_job_id"):
        environment = base_environment(directory, state)
        environment["COMPOSE_FILE"] = str(directory / "compose.json")
        credentials = parse_exports(
            run([str(enterprise / "scripts/local-db-env.sh")], enterprise, environment, capture=True)
        )
        container = run(
            compose_command(directory, state, "ps", "-q", "postgres"), enterprise, environment, capture=True
        ).strip()
        if not container:
            raise ValueError("owned PostgreSQL container is not running")
        crawl_id = str(uuid.uuid4())
        command = [
            "docker",
            "exec",
            "-i",
            container,
            "sh",
            "-c",
            (
                "IFS= read -r PGPASSWORD; export PGPASSWORD; exec psql -X -qAt -v ON_ERROR_STOP=1 "
                "-h 127.0.0.1 -U xberg_app -d xberg_enterprise"
            ),
        ]
        result = subprocess.run(
            command,
            input=credentials["LOCAL_POSTGRES_APPLICATION_PASSWORD"]
            + "\n"
            + crawl_fixture_sql(state["project_id"], crawl_id),
            capture_output=True,
            text=True,
            timeout=30,
            check=False,
        )  # noqa: S603
        if result.returncode != 0 or result.stdout.strip() != crawl_id:
            raise RuntimeError("terminal crawl fixture insertion failed or returned the wrong row count")
        state["crawl_job_id"] = crawl_id
        write_private(directory / "state.json", state)
    with (
        httpx.Client(timeout=10, trust_env=False) as client,
        client.stream(
            "GET",
            state["api_url"] + "/v1/crawl-jobs/" + state["crawl_job_id"] + "/events",
            headers={"Authorization": "Bearer " + state["api_key"]},
        ) as response,
    ):
        if response.status_code != 200 or "text/event-stream" not in response.headers.get("content-type", ""):
            raise RuntimeError("real authenticated idle SSE subscription was not accepted")
    print("Terminal crawl fixture ready for real idle SSE cancellation")  # noqa: T201


def up(directory: Path, state: dict[str, Any], enterprise: Path) -> None:
    """Start and verify the scoped stack before minting SDK fixture credentials."""
    environment = configure(directory, state, enterprise)
    if state["tier"] == "enterprise":
        run(
            compose_command(directory, state, "up", "-d", "--wait", "postgres", "nats", "gcs-emulator"),
            enterprise,
            environment,
        )
        run([str(enterprise / "scripts/local-db-migrate.sh")], enterprise, environment)
        with httpx.Client(timeout=10, trust_env=False) as client:
            response = client.post(
                f"http://127.0.0.1:{state['ports']['gcs']}/storage/v1/b", json={"name": "sdk-live-uploads"}
            )
            if response.status_code not in (200, 201, 409):
                raise RuntimeError("failed to create isolated storage bucket")
        run(
            compose_command(
                directory,
                state,
                "up",
                "-d",
                "sdk-vector-broker",
                "sdk-vector-worker",
                "sdk-backend",
                "sdk-api",
                "sdk-worker",
                "sdk-rag",
            ),
            enterprise,
            environment,
        )
        wait_ready(f"http://127.0.0.1:{state['ports']['broker_metrics']}/readyz")
        wait_ready(f"http://127.0.0.1:{state['ports']['worker_metrics']}/readyz")
        run([str(enterprise / "scripts/local-vector-index-claims.sh"), "enable"], enterprise, environment)
    else:
        run(compose_command(directory, state, "up", "-d", "pro"), enterprise, environment)
    wait_ready(state["api_url"] + "/readyz")
    wait_ready(state["control_plane_url"] + "/readyz")
    mint_fixture(directory, state)
    if state["tier"] == "enterprise":
        prepare_idle_crawl(directory, state, enterprise)
    print(f"{state['tier']} ready: {state['api_url']} (private state: {directory})")  # noqa: T201


def execute(state: dict[str, Any], command: list[str]) -> int:
    """Run a caller command with this stack's private connection environment."""
    if not state.get("api_key"):
        raise ValueError("stack has no SDK fixture key; run up first")
    environment = {
        **os.environ,
        "XBERG_API_KEY": state["api_key"],
        "XBERG_PROJECT_ID": state["project_id"],
        "XBERG_BASE_URL": state["api_url"],
        "XBERG_CONTROL_PLANE_URL": state["control_plane_url"],
        "XBERG_CONTROL_PLANE_TOKEN": state["control_plane_token"],
        "XBERG_ADMIN_KEY": state["admin_key"],
    }
    if state.get("crawl_job_id"):
        environment["XBERG_CRAWL_JOB_ID"] = state["crawl_job_id"]
    if state["tier"] == "enterprise" and state.get("upload_network"):
        environment["XBERG_UPLOAD_NETWORK"] = state["upload_network"]
        environment["XBERG_UPLOAD_RUNTIME_IMAGE"] = state["upload_runtime_image"]
    return subprocess.run(command, cwd=ROOT, env=environment, check=False).returncode  # noqa: S603


def main() -> int:
    """Dispatch an operation against the selected private stack state."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "command", choices=["up", "down", "reset", "key", "verify", "status", "exec", "prepare-idle-crawl"]
    )
    parser.add_argument("--tier", choices=["enterprise", "pro"], default="enterprise")
    parser.add_argument("--state-directory", type=Path)
    parser.add_argument("arguments", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    root_hash = hashlib.sha256(str(ROOT).encode()).hexdigest()[:12]
    default = Path(tempfile.gettempdir()) / f"xberg-sdk-{args.tier}-{os.getuid()}-{root_hash}"
    directory = (
        args.state_directory or Path(os.environ.get(f"XBERG_{args.tier.upper()}_STATE_DIR", str(default)))
    ).absolute()
    state = initialize_state(directory, args.tier) if args.command == "up" else read_state(directory, args.tier)
    enterprise = Path(
        os.environ.get("XBERG_ENTERPRISE_DIR", state.get("enterprise_directory", str(ROOT.parent / "xberg-enterprise")))
    )
    if args.command == "up":
        up(directory, state, enterprise.resolve())
    elif args.command == "prepare-idle-crawl":
        prepare_idle_crawl(directory, state, enterprise.resolve())
    elif args.command in {"down", "reset"}:
        arguments = ["down", "--timeout", "20"] + (["--volumes"] if args.command == "reset" else [])
        environment = base_environment(directory, state)
        environment["COMPOSE_FILE"] = str(directory / "compose.json")
        if state["tier"] == "enterprise":
            running = run(
                compose_command(directory, state, "ps", "--status", "running", "-q", "postgres"),
                enterprise,
                environment,
                capture=True,
            )
            if running.strip():
                run([str(enterprise / "scripts/local-vector-index-claims.sh"), "disable"], enterprise, environment)
        run(compose_command(directory, state, *arguments), enterprise, environment)
        if args.command == "reset":
            for name in ("api_key", "key_id", "project_id", "control_plane_token", "crawl_job_id"):
                state.pop(name, None)
            write_private(directory / "state.json", state)
    elif args.command == "key":
        if not state.get("api_key"):
            raise ValueError("run up to mint a project key")
        print(state["api_key"])  # noqa: T201
    elif args.command == "status":
        print(  # noqa: T201
            json.dumps(
                {key: state.get(key) for key in ("tier", "project", "api_url", "control_plane_url", "project_id")}
            )
        )  # noqa: T201
    else:
        command = args.arguments[1:] if args.arguments[:1] == ["--"] else args.arguments
        if args.command == "verify":
            command = [
                sys.executable,
                str(ROOT / "scripts/live-sdk-contracts.py"),
                "verify",
                "--tier",
                state["tier"],
                "--base-url",
                state["api_url"],
            ]
        if not command:
            raise ValueError("exec requires a command after --")
        return execute(state, command)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ValueError, RuntimeError, OSError, KeyError) as exc:
        print(f"SDK stack operation failed: {exc}", file=sys.stderr)  # noqa: T201
        raise SystemExit(1) from None
