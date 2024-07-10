# coding: utf-8

"""
parameters used for crop faces
"""

import os.path as osp
from dataclasses import dataclass
from typing import Union, List
from .base_config import PrintableConfig


@dataclass(repr=False)  # use repr from PrintableConfig
class CropConfig(PrintableConfig):
    dsize: int = 512  # crop size
    scale: float = 2.5  # scale factor
    vx_ratio: float = 0  # vx ratio
    vy_ratio: float = -0.125  # vy ratio +up, -down

    scale_crop_video: float = 2.0 # scale factor for cropping video
    vy_ratio_crop_video: float = -0.1  # vy ratio +up, -down for cropping video
    max_face_num: int = 0 # max face number, 0 mean no limit
    direction: str = 'large-small'  # direction of cropping
