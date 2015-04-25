# Copyright (C) 2011-2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

USE_CAMERA_STUB := true

-include device/sony/fuji-common/BoardConfigCommon.mk
-include vendor/sony/aoba/BoardConfigVendor.mk

TARGET_KERNEL_CONFIG := xperiaoverlay_fuji_aoba_defconfig

# Sony-supplied broadcom wlan module
BOARD_WLAN_BROADCOM := true

# Custom bluedroid includes
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/sony/aoba/bluetooth

# Partition information
BOARD_VOLD_MAX_PARTITIONS := 18

# the following two sizes are generous guesses
# since these partitions are not visible
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x01400000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x01400000

# Build kernel with cortex a8 optimized Linaro toolchain 4.7 for fast UI
TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.7.Linaro
# Recovery
TARGET_RECOVERY_FSTAB := device/sony/aoba/config/fstab.semc
TARGET_NO_SEPARATE_RECOVERY := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1056964608
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_USERIMAGES_USE_EXT4 := true

BOARD_SDCARD_INTERNAL_DEVICE := /dev/block/mmcblk0p18

TARGET_OTA_ASSERT_DEVICE := LT28h,aoba
