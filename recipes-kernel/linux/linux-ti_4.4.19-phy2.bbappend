FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

COMPATIBLE_MACHINE .= "|s7"
KERNEL_EXTRA_ARGS += "LOADADDR=80008000"

PR = "r2"

SRC_URI += "file://0001-scripts-Add-script-for-merging-zImage-with-dtb-to-uI.patch"
SRC_URI += "file://0002-Add-initial-support-for-S7-device.patch"
SRC_URI += "file://0003-dts-am335x-s7-base-Activate-1.8-V-supply-from-power-.patch"
SRC_URI += "file://defconfig"
