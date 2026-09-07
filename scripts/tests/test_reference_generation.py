"""Reference checks must detect drift without modifying a user's files."""

import importlib.util
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def load_generator():
    spec = importlib.util.spec_from_file_location("reference_generator", ROOT / "scripts/generate-reference.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_reference_check_does_not_rewrite_stale_files(tmp_path, monkeypatch):
    generator = load_generator()
    monkeypatch.setattr(generator, "OUT", tmp_path)
    monkeypatch.setattr(generator, "ROOT", tmp_path)
    (tmp_path / "CHANGELOG.md").write_text("# Changelog\n")
    monkeypatch.setattr(generator, "parity_failures", list)
    monkeypatch.setattr(generator, "render", lambda lang: f"expected {lang}\n")
    monkeypatch.setattr(sys, "argv", ["generate-reference.py", "--check"])
    for lang in generator.LANGS:
        (tmp_path / f"api-{lang}.md").write_text("stale\n")
    try:
        generator.main()
    except SystemExit as exc:
        assert exc.code == 1
    assert [(tmp_path / f"api-{lang}.md").read_text() for lang in generator.LANGS] == ["stale\n"] * 3


def test_go_initialisms_match_new_backend_public_surface():
    generator = load_generator()
    assert generator.snake_to_pascal("oauth_callback") == "OAuthCallback"
    assert generator.snake_to_pascal("backend_get_rag_config") == "BackendGetRAGConfig"
    assert generator.snake_to_pascal("get_rag_config") == "GetRagConfig"
