"""Omission-only nested settings follow the public xberg#2041 contract."""

import pytest

from xberg_io_sdk._generated_api.models.keyword_config import KeywordConfig as EnterpriseKeywords
from xberg_io_sdk._generated_api.models.tesseract_config import TesseractConfig as EnterpriseTesseract
from xberg_io_sdk._generated_pro.models.keyword_config import KeywordConfig as ProKeywords
from xberg_io_sdk._generated_pro.models.tesseract_config import TesseractConfig as ProTesseract

PREPROCESSING = {
    "auto_rotate": False,
    "binarization_method": "otsu",
    "contrast_enhance": False,
    "denoise": False,
    "deskew": True,
    "invert_colors": False,
    "target_dpi": 300,
}


@pytest.mark.parametrize("model", [EnterpriseKeywords, ProKeywords])
@pytest.mark.parametrize(
    "field,value",
    [
        ("rake_params", {"min_word_length": 2, "max_words_per_phrase": 3}),
        ("yake_params", {"window_size": 2}),
    ],
)
def test_keyword_references_accept_omission_and_objects_but_exclude_null(model, field, value):
    assert field not in model.from_dict({}).to_dict()
    assert model.from_dict({field: value}).to_dict()[field] == value
    with pytest.raises((AttributeError, TypeError)):
        model.from_dict({field: None})


@pytest.mark.parametrize("model", [EnterpriseTesseract, ProTesseract])
def test_preprocessing_accepts_omission_and_object_but_excludes_null(model):
    assert "preprocessing" not in model.from_dict({}).to_dict()
    assert model.from_dict({"preprocessing": PREPROCESSING}).to_dict()["preprocessing"] == PREPROCESSING
    with pytest.raises((AttributeError, TypeError)):
        model.from_dict({"preprocessing": None})
