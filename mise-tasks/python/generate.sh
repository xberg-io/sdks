#!/usr/bin/env bash
#MISE description="Regenerate all three Python schema sets (Enterprise + Pro + control plane)"
set -euo pipefail

# Each set from spec/<set>/openapi.yaml lands in its own module,
# packages/python/src/xberg_io_sdk/_generated_<set>. ~keep
pkg_dir=packages/python

generate_set() {
  local spec="$1" out="$2"
  rm -rf "$out"
  mkdir -p "$out"
  uv run python scripts/prepare-python-spec.py "$spec" "$out/_spec.json"
  uv run -m openapi_python_client generate \
    --path "$out/_spec.json" \
    --config "$pkg_dir/openapi-python-client.yaml" \
    --output-path "$out/_pkg" \
    --overwrite \
    --meta none
  mv "$out"/_pkg/* "$out"/
  rmdir "$out/_pkg"
  rm "$out/_spec.json"
  uv run python scripts/patch-python-compat.py "$out"
  touch "$out/__init__.py"
}

# FormatMetadata discriminator patch, a no-op when the spec has no FormatMetadata discriminator or the
# generated model file was not produced (e.g. the Pro schema set). ~keep
patch_format_metadata() {
  uv run python - "$1" "$2" <<'PY'
import sys
from pathlib import Path

from ruamel.yaml import YAML

spec_path, out = sys.argv[1], sys.argv[2]
spec = YAML(typ="safe").load(Path(spec_path))
schemas = (spec.get("components") or {}).get("schemas") or {}
format_metadata = schemas.get("FormatMetadata")
generated = Path(out) / "models" / "metadata.py"
if format_metadata is None or "discriminator" not in format_metadata or not generated.exists():
    print(f"FormatMetadata patch skipped for {out} (no discriminator / no model)")  # noqa: T201
    raise SystemExit(0)
mapping = format_metadata["discriminator"]["mapping"]
text = generated.read_text()
format_parser = "        def _parse_format_(\n"
start = text.index(format_parser)
end = text.index("        format_ = _parse_format_", start)
if "format_metadata_types" not in text[start:end]:
    marker = "            if isinstance(data, Unset):\n                return data\n"
    insert_at = text.index(marker, start) + len(marker)
    entries = []
    for tag, ref in sorted(mapping.items()):
        class_name = ref.rsplit("/", 1)[-1]
        entries.append(f'                    "{tag}": {class_name},')
    block = (
        "\n"
        "            if isinstance(data, dict):\n"
        "                format_metadata_types = {\n"
        + "\n".join(entries)
        + "\n"
        "                }\n"
        "                parser = format_metadata_types.get(data.get(\"format_type\"))\n"
        "                if parser is not None:\n"
        "                    return parser.from_dict(data)\n"
    )
    text = text[:insert_at] + block + text[insert_at:]
generated.write_text(text)
print(f"FormatMetadata patch applied to {out}")  # noqa: T201
PY
}

sets=(api pro backend)
for set in "${sets[@]}"; do
  generate_set "spec/$set/openapi.yaml" "$pkg_dir/src/xberg_io_sdk/_generated_$set"
done
for set in "${sets[@]}"; do
  patch_format_metadata "spec/$set/openapi.yaml" "$pkg_dir/src/xberg_io_sdk/_generated_$set"
done
