FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

COMPATIBLE_MACHINE = "|s7"
KERNEL_EXTRA_ARGS += "LOADADDR=80008000"

PR = "r4"

SRC_URI += "file://0001-scripts-Add-script-for-merging-zImage-with-dtb-to-uI.patch"
SRC_URI += "file://0002-Add-initial-support-for-S7-device.patch"
SRC_URI += "file://0003-dts-am335x-s7-base-Activate-1.8-V-supply-from-power-.patch"
SRC_URI += "file://0004-dts-am335x-s7-base-Remove-max-freq-from-mmc2.patch"
SRC_URI += "file://0005-dts-am335s-s7-base-Change-level-of-gsm_en-io.patch"
SRC_URI += "file://0006-dts-am335x-s7-base-Add-adc-channels-to-base.patch"
SRC_URI += "file://0007-dts-am335x-s7-base-Export-gpio31-to-userspace.patch"
SRC_URI += "file://0008-dts-am335x-s7-base-Make-mmc2-interface-removable.patch"
SRC_URI += "file://defconfig"
