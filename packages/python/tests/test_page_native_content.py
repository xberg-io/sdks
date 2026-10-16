"""Native-content page options remain typed and preserve omission versus false."""

import pytest

from xberg_io_sdk._generated_api.models.extraction_config import ExtractionConfig as EnterpriseConfig
from xberg_io_sdk._generated_api.types import UNSET as ENTERPRISE_UNSET
from xberg_io_sdk._generated_pro.models.file_extraction_config import FileExtractionConfig as ProConfig
from xberg_io_sdk._generated_pro.types import UNSET as PRO_UNSET


@pytest.mark.parametrize(
    "config_type,unset", [(EnterpriseConfig, ENTERPRISE_UNSET), (ProConfig, PRO_UNSET)], ids=["enterprise", "pro"]
)
@pytest.mark.parametrize("flag", [True, False, None], ids=["true", "false", "omitted"])
def test_native_content_page_option_has_typed_access_and_exact_round_trip(config_type, unset, flag):
    pages = {"extract_pages": True}
    if flag is not None:
        pages["keep_native_content"] = flag
    raw = {"pages": pages}
    config = config_type.from_dict(raw)
    if flag is None:
        assert config.pages.keep_native_content is unset
    else:
        assert config.pages.keep_native_content is flag
    assert config.to_dict() == raw
