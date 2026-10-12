import type { components, proComponents } from "../src/index.js";

type EnterpriseSchemas = components["schemas"];
type ProSchemas = proComponents["schemas"];

export const enterpriseLlm: EnterpriseSchemas["LlmConfig"] = { model: "openai/gpt-4o-mini" };
export const proLlm: ProSchemas["LlmConfig"] = { model: "openai/gpt-4o-mini" };

export const legacyEnterpriseThreshold: EnterpriseSchemas["TesseractConfig"]["thresholding_method"] = true;
export const legacyProThreshold: ProSchemas["TesseractConfig"]["thresholding_method"] = false;
export const integerEnterpriseThreshold: EnterpriseSchemas["TesseractConfig"]["thresholding_method"] = 2;
export const integerProThreshold: ProSchemas["TesseractConfig"]["thresholding_method"] = 1;

export const enterprisePreprocessing: EnterpriseSchemas["ImagePreprocessingConfig"] = {
  auto_rotate: false,
  binarization_method: "otsu",
  contrast_enhance: false,
  denoise: false,
  deskew: true,
  invert_colors: false,
  target_dpi: 300,
};
export const proPreprocessing: ProSchemas["ImagePreprocessingConfig"] = enterprisePreprocessing;
export const shadedRows: EnterpriseSchemas["ImagePreprocessingConfig"] = {
  ...enterprisePreprocessing,
  normalize_shaded_rows: true,
};

export const nullEnterpriseKey: EnterpriseSchemas["LlmConfig"] = {
  model: "openai/gpt-4o-mini",
  // @ts-expect-error -- ~keep The service rejects explicit null rather than treating it as an omitted key.
  api_key: null,
};
// @ts-expect-error -- ~keep The Pro service applies the same explicit-null rejection.
export const nullProKey: ProSchemas["LlmConfig"] = { model: "openai/gpt-4o-mini", api_key: null };
// @ts-expect-error -- ~keep Legacy boolean support must not admit string threshold values.
export const stringThreshold: EnterpriseSchemas["TesseractConfig"]["thresholding_method"] = "adaptive";
export const invalidShadedRows: EnterpriseSchemas["ImagePreprocessingConfig"] = {
  ...enterprisePreprocessing,
  // @ts-expect-error -- ~keep Optionality must preserve the shaded-row flag's boolean type.
  normalize_shaded_rows: 1,
};
