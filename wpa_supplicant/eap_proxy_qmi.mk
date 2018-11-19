
LOCAL_PATH := $(call my-dir)

ifeq ($(BOARD_HAS_QCOM_WLAN), true)
L_CFLAGS += -DSIM_AKA_IDENTITY_IMSI
#L_CFLAGS += -DSIM_AKA_IMSI_RAW_ENABLED

ifdef CONFIG_EAP_PROXY_DUAL_SIM
L_CFLAGS += -DCONFIG_EAP_PROXY_DUAL_SIM
endif

LIB_SHARED_EAP_PROXY := libqmi_cci libqmiservices libidl
INCLUDES += $(TARGET_OUT_HEADERS)/qmi-framework/inc
INCLUDES += $(TARGET_OUT_HEADERS)/qmi/inc
INCLUDES += $(TARGET_OUT_HEADERS)/qmi/platform
INCLUDES += $(TARGET_OUT_HEADERS)/qmi/core/lib/inc

LIB_HEADER_EAP_PROXY := libril-qc-qmi-services-headers

ifdef CONFIG_EAP_PROXY_MDM_DETECT
L_CFLAGS += -DCONFIG_EAP_PROXY_MDM_DETECT
INCLUDES += $(TARGET_OUT_HEADERS)/libmdmdetect/inc
LIB_SHARED_EAP_PROXY += libmdmdetect
endif

# EAP-AKA' (enable CONFIG_PCSC, if EAP-AKA' is used).
# This requires CONFIG_EAP_AKA to be enabled, too.
# This is supported only in B Family devices.
ifdef CONFIG_EAP_PROXY_AKA_PRIME
L_CFLAGS += -DCONFIG_EAP_PROXY_AKA_PRIME
endif

ifdef CONFIG_EAP_PROXY_MSM8994_TARGET
L_CFLAGS += -DCONFIG_EAP_PROXY_MSM8994_TARGET
endif

ifeq ($(CONFIG_EAP_PROXY_USE_CONFIG_IDENTITY), y)
L_CFLAGS += -DEAP_PROXY_USE_CONFIG_IDENTITY
endif

#ANDROID_SETGROUPS_OVERRIDE := AID_RADIO AID_WIFI AID_KEYSTORE AID_DIAG AID_INET AID_QCOM_DIAG AID_NET_RAW AID_LOG
L_CFLAGS += -DANDROID_SETGROUPS_OVERRIDE=1001,1010,1017,2002,1003,3009,3004,1007
endif
