import { describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { enterpriseNativeContentPages, proNativeContentPages } from "./ocr-result-contract.fixture.js";

describe.each([
  ["enterprise", enterpriseNativeContentPages],
  ["pro", proNativeContentPages],
] as const)("%s native-content extraction requests", (target, pages) => {
  describe.each(["global", "per-file"] as const)("%s configuration", (placement) => {
    it.each([0, 1, 2])("sends the exact page configuration for case %i", async (index) => {
      const requests: Request[] = [];
      const baseUrl = `https://${target}.native-content.test`;
      const client = new XbergClient({
        target,
        baseUrl,
        controlPlaneBaseUrl: "https://control-plane.native-content.test",
        apiKey: "fixture-key",
        fetch: async (input, init) => {
          requests.push(new Request(input, init));
          return Response.json({ job_ids: ["native-content-job"], status: "pending" }, { status: 202 });
        },
      });
      const pageConfig = pages[index];
      const job = await client.extract({
        file: new File(["Invoice total 125.50"], "invoice.txt", { type: "text/plain" }),
        ...(placement === "global"
          ? { options: { extraction_config: { pages: pageConfig } } }
          : { config: { pages: pageConfig } }),
      });
      expect(requests).toHaveLength(1);
      const request = requests[0];
      expect(request?.url).toBe(`${baseUrl}/v1/extract`);
      expect(request?.method).toBe("POST");
      expect(request?.headers.get("authorization")).toBe("Bearer fixture-key");
      const form = await request?.formData();
      const configKey = placement === "global" ? "options" : "config-invoice.txt";
      expect(Array.from(form?.keys() ?? [])).toEqual(["file", configKey]);
      const flag = [true, false, undefined][index];
      const expectedPages = { extract_pages: true, ...(flag === undefined ? {} : { keep_native_content: flag }) };
      const expectedConfig =
        placement === "global" ? { extraction_config: { pages: expectedPages } } : { pages: expectedPages };
      expect(JSON.parse(String(form?.get(configKey)))).toEqual(expectedConfig);
      const file = form?.get("file");
      expect(file).toBeInstanceOf(File);
      if (!(file instanceof File)) throw new Error("missing multipart file");
      expect({ name: file.name, type: file.type, text: await file.text() }).toEqual({
        name: "invoice.txt",
        type: "text/plain",
        text: "Invoice total 125.50",
      });
      expect(job).toMatchObject({
        id: "native-content-job",
        status: "pending",
        filename: "invoice.txt",
        mime_type: "text/plain",
      });
    });
  });
});
