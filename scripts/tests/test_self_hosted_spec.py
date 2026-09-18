from pathlib import Path

from ruamel.yaml import YAML

ROOT = Path(__file__).resolve().parents[2]


def test_enterprise_spec_does_not_publish_a_default_deployment_url() -> None:
    document = YAML(typ="safe").load(ROOT / "spec" / "api" / "openapi.yaml")

    assert "servers" not in document
    assert "externalDocs" not in document
