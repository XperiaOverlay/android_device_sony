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

# Inherit device configuration
$(call inherit-product, device/sony/aoba/full_aoba.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)
$(call inherit-product, vendor/cm/config/gsm.mk)

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
PRODUCT_NAME=LT28h \
PRODUCT_DEVICE=aoba \
BUILD_FINGERPRINT="SEMC/LT28h_1267-9107/LT28h:4.0.4/6.1.E.3.7/-PN-zw:user/release-keys" \
PRIVATE_BUILD_DESC="LT28h-user 4.0.4 6.1.E.3.7 -PN-zw test-keys"

# Device identifier. This must come after all inclusions
PRODUCT_NAME := cm_aoba
PRODUCT_GMS_CLIENTID_BASE := android-sonyericsson

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

# Boot Animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Release name
PRODUCT_RELEASE_NAME := aoba

# Custom tag for unofficial builds
TARGET_UNOFFICIAL_BUILD_ID := XperiaOverlay
