#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/fleur

# API
PRODUCT_SHIPPING_API_LEVEL := 30

# Virtual A/B
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# A/B
PRODUCT_PACKAGES += \
    otapreopt_script

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot Control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl.recovery \
    android.hardware.boot@1.1-impl \
    bootctrl.mt6781.recovery

# Update Engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Fastbootd
PRODUCT_PACKAGES += \
	fastbootd \
	android.hardware.fastboot@1.0-impl-mock

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 31

# MTK PlPath Utils
PRODUCT_PACKAGES += \
    mtk_plpath_utils.recovery

# Keystore
PRODUCT_PACKAGES += \
    android.system.keystore2

# Additional Libraries
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster41 \
    libpuresoftkeymasterdevice

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster41.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so

# libion & libxml2
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Vibrator
PRODUCT_PACKAGES += \
	android.hardware.vibrator@1.2-service.mtk.recovery
