import type { ExtractedDocument, ExtractionConfig, components, proComponents } from "../src/index.js";

export const recoveredDocument: ExtractedDocument = {
  content: "Recovered invoice total 125.50",
  mime_type: "application/pdf",
  metadata: {},
  tables: [],
  ocr_page_failures: [{ page: 1, error: "synthetic timeout", recovered: true }],
  pages: [{ page_number: 1, content: "Recovered invoice total 125.50", native_content: "Invoice total 125.50" }],
};
export const sharedOcrConfig: ExtractionConfig = {
  ocr: { backend: "paddleocr", paddle_ocr_settings: { device: "cpu", threads: 2 } },
};
export const enterpriseDocument: components["schemas"]["ExtractedDocument"] = recoveredDocument;
export const proDocument: proComponents["schemas"]["ExtractedDocument"] = recoveredDocument;

// @ts-expect-error -- ~keep xberg#2041 defines this reference as omission-only, not nullable.
export const enterpriseNullRake: components["schemas"]["KeywordConfig"]["rake_params"] = null;
// @ts-expect-error -- ~keep xberg#2041 defines this reference as omission-only, not nullable.
export const enterpriseNullYake: components["schemas"]["KeywordConfig"]["yake_params"] = null;
// @ts-expect-error -- ~keep xberg#2041 defines this reference as omission-only, not nullable.
export const enterpriseNullPreprocessing: components["schemas"]["TesseractConfig"]["preprocessing"] = null;
// @ts-expect-error -- ~keep xberg#2041 defines this reference as omission-only, not nullable.
export const proNullRake: proComponents["schemas"]["KeywordConfig"]["rake_params"] = null;
// @ts-expect-error -- ~keep xberg#2041 defines this reference as omission-only, not nullable.
export const proNullYake: proComponents["schemas"]["KeywordConfig"]["yake_params"] = null;
// @ts-expect-error -- ~keep xberg#2041 defines this reference as omission-only, not nullable.
export const proNullPreprocessing: proComponents["schemas"]["TesseractConfig"]["preprocessing"] = null;

export const enterprisePresentRake: components["schemas"]["KeywordConfig"]["rake_params"] = {
  min_word_length: 2,
  max_words_per_phrase: 3,
};
export const enterprisePresentYake: components["schemas"]["KeywordConfig"]["yake_params"] = { window_size: 2 };
export const proPresentRake: proComponents["schemas"]["KeywordConfig"]["rake_params"] = enterprisePresentRake;
export const proPresentYake: proComponents["schemas"]["KeywordConfig"]["yake_params"] = enterprisePresentYake;
export const enterprisePresentPreprocessing: components["schemas"]["TesseractConfig"]["preprocessing"] = {
  auto_rotate: false,
  binarization_method: "otsu",
  contrast_enhance: false,
  denoise: false,
  deskew: true,
  invert_colors: false,
  target_dpi: 300,
};
export const proPresentPreprocessing: proComponents["schemas"]["TesseractConfig"]["preprocessing"] =
  enterprisePresentPreprocessing;
