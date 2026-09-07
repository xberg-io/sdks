import { fileURLToPath } from "node:url";
import ts from "typescript";
import { expect, it } from "vitest";

it("accepts nonempty opaque JSON through public methods while preserving declared field types", () => {
  const fixture = fileURLToPath(new URL("./opaque-json.fixture.ts", import.meta.url));
  const program = ts.createProgram([fixture], {
    noEmit: true,
    strict: true,
    skipLibCheck: true,
    target: ts.ScriptTarget.ESNext,
    lib: ["lib.esnext.d.ts"],
    types: ["node"],
    module: ts.ModuleKind.NodeNext,
    moduleResolution: ts.ModuleResolutionKind.NodeNext,
  });
  const diagnostics = ts.getPreEmitDiagnostics(program).map((diagnostic) => ({
    code: diagnostic.code,
    message: ts.flattenDiagnosticMessageText(diagnostic.messageText, "\n"),
  }));
  expect(diagnostics).toEqual([]);
});
