import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import ts from "typescript";

const directory = process.argv[2];
if (!directory) throw new Error("Usage: node align-generated.mjs <generated-directory>");

function member(members, name) {
  const matches = members.filter((value) => value.name?.text === name);
  if (matches.length !== 1) throw new Error(`Expected exactly one declaration for ${name}`);
  return matches[0];
}

// ~keep These schema corrections reflect current Rust deserialization: omitted keys and
// defaulted shaded-row flags are accepted, as are legacy boolean Tesseract thresholds.
for (const tier of ["api", "pro"]) {
  const path = join(directory, `${tier}.d.ts`);
  const source = readFileSync(path, "utf8");
  const parsed = ts.createSourceFile(path, source, ts.ScriptTarget.Latest, true);
  const components = member(parsed.statements, "components");
  const schemas = member(components.members, "schemas");
  const edits = [];

  const property = (schema, name, expectedType, optional) => {
    const declaration = member(member(schemas.type.members, schema).type.members, name);
    if (declaration.type.getText(parsed) !== expectedType || Boolean(declaration.questionToken) !== optional) {
      throw new Error(`Unexpected generated declaration: ${tier}.${schema}.${name}`);
    }
    return declaration;
  };

  const threshold = property("TesseractConfig", "thresholding_method", "number", false);
  edits.push({
    start: threshold.type.getStart(parsed),
    end: threshold.type.end,
    text: "number | boolean",
  });

  const shadedRows = property("ImagePreprocessingConfig", "normalize_shaded_rows", "boolean", false);
  edits.push({ start: shadedRows.name.end, end: shadedRows.name.end, text: "?" });

  const apiKey = property("LlmConfig", "api_key", "string", tier === "pro");
  if (tier === "api") edits.push({ start: apiKey.name.end, end: apiKey.name.end, text: "?" });

  let updated = source;
  for (const edit of edits.sort((left, right) => right.start - left.start)) {
    updated = updated.slice(0, edit.start) + edit.text + updated.slice(edit.end);
  }
  writeFileSync(path, updated, "utf8");
}
