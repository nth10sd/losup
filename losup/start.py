# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

"""start.py"""

from __future__ import annotations

from logging import INFO as INFO_LOG_LEVEL

from losup.common import LOSDevice
from losup.util.logging import get_logger
from losup.util.utils import add_one

RUN_LOG = get_logger(__name__)
RUN_LOG.setLevel(INFO_LOG_LEVEL)


def main() -> None:
    """main function"""
    LOSDevice("NewType")
    RUN_LOG.warning(add_one(2))
    RUN_LOG.error("foo")
