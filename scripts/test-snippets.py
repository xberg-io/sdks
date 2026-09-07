#!/usr/bin/env python3
"""Execute every documented snippet against local services and built SDK packages."""

from __future__ import annotations

import argparse
import ipaddress
import json
import os
import re
import stat
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import urlsplit


@dataclass(frozen=True)
class Snippet:
    """One independently executable documentation fence."""

    name: str
    language: str
    code: str
    targets: list[str]
    side_effect: str
    requires: list[str]
    expect_stdout: str | None


def parse_metadata(text: str, name: str) -> tuple[dict, str]:
    """Read a small YAML subset with JSON values, rejecting unknown metadata."""
    lines = text.splitlines(keepends=True)
    if not lines or lines[0].strip() != "---":
        raise ValueError(f"{name}: missing snippet metadata")
    metadata = {}
    for index, line in enumerate(lines[1:], 1):
        if line.strip() == "---":
            validate_metadata(metadata, name)
            return metadata, "".join(lines[index + 1 :])
        key, separator, value = line.partition(":")
        if not separator or key in metadata:
            raise ValueError(f"{name}: invalid or duplicate metadata")
        metadata[key] = json.loads(value)
    raise ValueError(f"{name}: unclosed metadata")


def validate_metadata(metadata: dict, name: str) -> None:
    """Reject undocumented, empty, or misspelled execution declarations."""
    required = {"targets", "side_effect", "requires"}
    if not required <= metadata.keys() or metadata.keys() - required - {"expect_stdout"}:
        raise ValueError(f"{name}: unknown or missing metadata")
    for key, allowed in [("targets", {"pro", "enterprise"}), ("requires", {"document", "crawl-job"})]:
        values = metadata[key]
        if not isinstance(values, list) or any(not isinstance(value, str) or value not in allowed for value in values):
            raise ValueError(f"{name}: invalid {key}")
        if len(values) != len(set(values)):
            raise ValueError(f"{name}: duplicate {key}")
    if (
        not metadata["targets"]
        or not isinstance(metadata["side_effect"], str)
        or metadata["side_effect"] not in {"safe", "scratch-project"}
    ):
        raise ValueError(f"{name}: invalid targets or side_effect")
    marker = metadata.get("expect_stdout")
    if marker is not None and (not isinstance(marker, str) or not marker):
        raise ValueError(f"{name}: invalid expect_stdout")


def parse_fences(text: str, name: str) -> list[tuple[str, str]]:
    """Read every fence and fail rather than ignore unsupported languages."""
    aliases = {"python": "python", "ts": "typescript", "typescript": "typescript", "go": "go"}
    result = []
    language = None
    body = []
    for line in text.splitlines(keepends=True):
        if line.lstrip().startswith(("```", "~~~")):
            if language is not None:
                if line.strip() != "```" or not "".join(body).strip():
                    raise ValueError(f"{name}: invalid or empty fence")
                result.append((language, "".join(body)))
                language, body = None, []
            else:
                match = re.fullmatch(r'```(\w+)(?:\s+title="[^"]*")?\s*', line.strip())
                if match is None or match[1] not in aliases:
                    raise ValueError(f"{name}: unsupported fence")
                language = aliases[match[1]]
        elif language is not None:
            body.append(line)
    if language is not None or not result:
        raise ValueError(f"{name}: unclosed or missing fences")
    return result


def discover(root: Path) -> list[Snippet]:
    """Discover every Markdown snippet in deterministic order."""
    snippets = []
    for path in sorted(root.rglob("*")):
        if not path.is_file():
            continue
        if path.suffix not in {".md", ".mdx"}:
            raise ValueError(f"{path}: unsupported snippet file")
        name = str(path.relative_to(root))
        metadata, text = parse_metadata(path.read_text(encoding="utf-8"), name)
        for index, (language, code) in enumerate(parse_fences(text, name), 1):
            snippets.append(
                Snippet(
                    f"{name}:{index}",
                    language,
                    code,
                    metadata["targets"],
                    metadata["side_effect"],
                    metadata["requires"],
                    metadata.get("expect_stdout"),
                )
            )
    if not snippets:
        raise ValueError("No snippets discovered")
    return snippets


def execution_plan(snippets: list[Snippet], targets: list[str]) -> list[tuple[Snippet, str]]:
    """Expand each fence once for each declared selected tier."""
    plan = [(snippet, target) for snippet in snippets for target in targets if target in snippet.targets]
    if not plan:
        raise ValueError("No executions selected")
    return sorted(plan, key=lambda item: "crawl-job" in item[0].requires)


def local_url(value: str) -> str:
    """Permit local service origins only, without embedded credentials."""
    parsed = urlsplit(value)
    host = parsed.hostname or ""
    try:
        loopback = host == "localhost" or ipaddress.ip_address(host).is_loopback
    except ValueError:
        loopback = False
    if (
        not loopback
        or parsed.scheme not in {"http", "https"}
        or parsed.username
        or parsed.password
        or parsed.query
        or parsed.fragment
    ):
        raise ValueError("Service URL must be local and contain no embedded credentials, query, or fragment")
    return value.rstrip("/")


def child_environment(values: dict[str, str]) -> dict[str, str]:
    """Avoid forwarding unrelated account credentials or network proxies."""
    allowed = {
        "PATH",
        "HOME",
        "TMPDIR",
        "TEMP",
        "SYSTEMROOT",
        "LANG",
        "LC_ALL",
        "UV_CACHE_DIR",
        "PNPM_HOME",
        "GOCACHE",
        "GOMODCACHE",
    }
    environment = {key: value for key, value in os.environ.items() if key in allowed}
    environment.update(
        {
            "NO_PROXY": "localhost,127.0.0.1,::1",
            "GOPROXY": "off",
            "GOSUMDB": "off",
            "GOTOOLCHAIN": "local",
            "UV_OFFLINE": "true",
            "UV_PYTHON_DOWNLOADS": "never",
        }
    )
    environment.update(values)
    return environment


def run_command(
    command: list[str],
    directory: Path,
    environment: dict[str, str],
    name: str,
    *,
    timeout: float = 120,
    expect_stdout: str | None = None,
) -> str:
    """Run a bounded child and report redacted diagnostics on failure."""
    try:
        result = subprocess.run(
            command, cwd=directory, env=environment, capture_output=True, text=True, timeout=timeout, check=False
        )
    except subprocess.TimeoutExpired as error:
        raise ValueError(f"{name}: timed out after {timeout} seconds") from error
    if result.returncode:
        output = result.stdout + result.stderr
        for key, value in environment.items():
            if value and any(word in key for word in ("KEY", "TOKEN", "PASSWORD")):
                output = output.replace(value, "[redacted]")
        raise ValueError(f"{name}: exit {result.returncode}\n{output[-4000:]}")
    if expect_stdout is not None and result.stdout.splitlines() != [expect_stdout]:
        raise ValueError(f"{name}: stdout did not match the exact expected marker {expect_stdout!r}")
    return result.stdout


def read_private_state(path: Path) -> dict:
    """Open a private owned regular state file without following a symbolic link."""
    if not stat.S_ISREG(path.lstat().st_mode):
        raise ValueError("Live state must be a regular file, not a symbolic link or special file")
    descriptor = os.open(path, os.O_RDONLY | getattr(os, "O_NOFOLLOW", 0) | getattr(os, "O_NONBLOCK", 0))
    with os.fdopen(descriptor, encoding="utf-8") as source:
        metadata = os.fstat(source.fileno())
        if not stat.S_ISREG(metadata.st_mode):
            raise ValueError("Live state must be a regular file")
        if stat.S_IMODE(metadata.st_mode) != 0o600:
            raise ValueError("Live state must be private with mode 0600")
        if hasattr(os, "getuid") and metadata.st_uid != os.getuid():
            raise ValueError("Live state must be owned by the current user")
        value = json.load(source)
    if not isinstance(value, dict):
        raise ValueError("Live state must be an object")
    return value


def state_environment(path: Path | None, target: str, root: Path) -> dict[str, str]:
    """Load a private harness state or an explicitly supplied local environment."""
    state = read_private_state(path) if path else {}
    tier = state.get("tier") if path else os.environ.get("XBERG_TARGET")
    if tier != target:
        raise ValueError(f"{target}: live state tier must match the selected tier exactly")
    fields = {
        "api_url": "XBERG_BASE_URL",
        "control_plane_url": "XBERG_CONTROL_PLANE_URL",
        "api_key": "XBERG_API_KEY",
        "project_id": "XBERG_PROJECT_ID",
        "control_plane_token": "XBERG_CONTROL_PLANE_TOKEN",
        "crawl_job_id": "XBERG_CRAWL_JOB_ID",
    }
    values = {
        environment: state.get(field, "") if path else os.environ.get(environment, "")
        for field, environment in fields.items()
    }
    if any(not isinstance(value, str) for value in values.values()):
        raise ValueError(f"{target}: live state fields must be strings")
    if not values["XBERG_BASE_URL"] or not values["XBERG_API_KEY"] or not values["XBERG_PROJECT_ID"]:
        raise ValueError(f"{target}: missing live service state (URL, project ID, and project API key required)")
    values["XBERG_BASE_URL"] = local_url(values["XBERG_BASE_URL"])
    values["XBERG_CONTROL_PLANE_URL"] = local_url(values["XBERG_CONTROL_PLANE_URL"] or values["XBERG_BASE_URL"])
    values.update(
        {
            "XBERG_TARGET": target,
            "XBERG_DOCUMENT": str(root / "test_documents" / "snippet.txt"),
            "XBERG_STREAM_TIMEOUT_SECONDS": "2",
        }
    )
    return values


def artifact(path: Path | None, root: Path, pattern: str) -> Path:
    """Require one explicit built package rather than select stale artifacts silently."""
    candidates = [path] if path else list((root / "dist").glob(pattern))
    if len(candidates) != 1 or not candidates[0].is_file():
        raise ValueError(f"Expected exactly one locally built {pattern} artifact; pass its path explicitly")
    return candidates[0].resolve()


def cached_runtime_packages(root: Path) -> dict[str, str]:
    """Resolve the already installed SDK runtime closure without registry metadata."""
    package = root / "packages/typescript/package.json"
    pending = [(package, root / "packages/typescript/node_modules")]
    versions = {}
    packages = {}
    while pending:
        manifest, modules = pending.pop()
        for name in json.loads(manifest.read_text(encoding="utf-8")).get("dependencies", {}):
            dependency = (modules / name).resolve() / "package.json"
            data = json.loads(dependency.read_text(encoding="utf-8"))
            if name in versions:
                if versions[name] != data["version"]:
                    raise ValueError(f"Runtime dependency {name} has conflicting locked versions")
                continue
            versions[name] = data["version"]
            packages[name] = f"file:{dependency.parent}"
            parent_modules = dependency.parent.parent
            if name.startswith("@"):
                parent_modules = parent_modules.parent
            pending.append((dependency, parent_modules))
    return packages


def prepare_language(language: str, directory: Path, arguments: argparse.Namespace, root: Path) -> list[str]:
    """Install only local packages and cached dependencies in an isolated project."""
    environment = child_environment({})
    if language == "python":
        wheel = artifact(arguments.python_wheel, root, "*.whl")
        run_command(["uv", "venv", str(directory / ".venv")], directory, environment, "Python environment")
        executable = directory / ".venv" / ("Scripts/python.exe" if os.name == "nt" else "bin/python")
        run_command(
            ["uv", "pip", "install", "--offline", "--python", str(executable), str(wheel)],
            directory,
            environment,
            "Python package install",
        )
        return [str(executable)]
    if language == "typescript":
        package = artifact(arguments.typescript_tarball, root, "xberg-io-sdk-*.tgz")
        (directory / "package.json").write_text(
            json.dumps({"private": True, "type": "module", "dependencies": {"@xberg-io/sdk": f"file:{package}"}}),
            encoding="utf-8",
        )
        (directory / "pnpm-workspace.yaml").write_text(
            json.dumps({"overrides": cached_runtime_packages(root)}), encoding="utf-8"
        )
        run_command(
            ["pnpm", "install", "--offline", "--ignore-scripts"], directory, environment, "TypeScript package install"
        )
        return ["node", "--experimental-strip-types"]
    source = (arguments.go_source or root / "packages/go").resolve()
    manifest = (source / "go.mod").read_text(encoding="utf-8")
    version = re.search(r"^go (\S+)$", manifest, re.MULTILINE)
    if version is None:
        raise ValueError("Local Go SDK has no toolchain declaration")
    (directory / "go.mod").write_text(
        f"module snippets\n\ngo {version[1]}\n\nrequire github.com/xberg-io/sdks/packages/go v0.0.0\nreplace github.com/xberg-io/sdks/packages/go => {json.dumps(str(source))}\n",
        encoding="utf-8",
    )
    return ["go"]


def execute_snippet(snippet: Snippet, target: str, directory: Path, command: list[str], values: dict[str, str]) -> None:
    """Run the actual displayed code, honoring fixture and side-effect declarations."""
    name = f"{snippet.name} [{target}]"
    if "document" in snippet.requires and not Path(values["XBERG_DOCUMENT"]).is_file():
        raise ValueError(f"{name}: missing document fixture")
    if "crawl-job" in snippet.requires and not values["XBERG_CRAWL_JOB_ID"]:
        raise ValueError(f"{name}: missing live idle crawl job fixture")
    if snippet.side_effect == "scratch-project" and not values["XBERG_CONTROL_PLANE_TOKEN"]:
        raise ValueError(f"{name}: scratch project lifecycle requires a fixture control-plane token")
    extension = {"python": "py", "typescript": "ts", "go": "go"}[snippet.language]
    source = directory / f"snippet.{extension}"
    source.write_text(snippet.code, encoding="utf-8")
    environment = child_environment(values)
    if snippet.language == "go":
        executable = directory / ("snippet.exe" if os.name == "nt" else "snippet-bin")
        run_command(
            [*command, "build", "-mod=mod", "-o", str(executable), str(source)],
            directory,
            child_environment({}),
            name + " build",
        )
        invocation = [str(executable)]
    else:
        if snippet.language == "typescript":
            root = Path(__file__).resolve().parents[1]
            run_command(
                [
                    "node",
                    str(root / "node_modules/typescript/bin/tsc"),
                    "--noEmit",
                    "--strict",
                    "--skipLibCheck",
                    "--target",
                    "esnext",
                    "--module",
                    "nodenext",
                    "--types",
                    "node",
                    "--typeRoots",
                    str(root / "packages/typescript/node_modules/@types"),
                    str(source),
                ],
                directory,
                child_environment({}),
                name + " typecheck",
            )
        invocation = [*command, str(source)]
    run_command(invocation, directory, environment, name, expect_stdout=snippet.expect_stdout)
    print(f"PASS {name}")  # noqa: T201


def main() -> int:
    """Run the documentation gate; discovery alone is explicitly non-validation."""
    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--snippets-root", type=Path, default=root / "docs-site/src/snippets")
    parser.add_argument("--target", choices=["pro", "enterprise"], action="append")
    parser.add_argument("--python-wheel", type=Path)
    parser.add_argument("--typescript-tarball", type=Path)
    parser.add_argument("--go-source", type=Path)
    parser.add_argument("--enterprise-state", type=Path)
    parser.add_argument("--pro-state", type=Path)
    parser.add_argument("--list", action="store_true", help="List work only; does not validate execution")
    arguments = parser.parse_args()
    try:
        snippets = discover(arguments.snippets_root)
        targets = list(dict.fromkeys(arguments.target or ["pro", "enterprise"]))
        plan = execution_plan(snippets, targets)
        print(f"Discovered {len(snippets)} fences; expected executions: {len(plan)}", flush=True)  # noqa: T201
        if arguments.list:
            for snippet, target in plan:
                print(f"{snippet.name} [{target}]")  # noqa: T201
            return 0
        states = {target: state_environment(getattr(arguments, f"{target}_state"), target, root) for target in targets}
        completed = 0
        with tempfile.TemporaryDirectory(prefix="xberg-snippets-") as temporary:
            prepared = {}
            for language in sorted({snippet.language for snippet, _ in plan}):
                directory = Path(temporary) / language
                directory.mkdir()
                prepared[language] = (directory, prepare_language(language, directory, arguments, root))
            for snippet, target in plan:
                directory, command = prepared[snippet.language]
                execute_snippet(snippet, target, directory, command, states[target])
                completed += 1
        if completed != len(plan):
            raise ValueError(f"Expected {len(plan)} executions, completed {completed}")
        print(f"Completed {completed}/{len(plan)} snippet executions")  # noqa: T201
        return 0
    except (ValueError, OSError) as error:
        print(f"Snippet validation failed: {error}", file=sys.stderr)  # noqa: T201
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
