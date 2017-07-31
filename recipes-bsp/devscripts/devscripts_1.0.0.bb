SUMMARY = "Diffrent scripts for controlling diffrent tasks"
HOMEPAGE = "http://www.sitec-systems.de"
SECTION = "base"
MAINTAINER = "Robert Lehmann <robert.lehmann@sitec-systems.de>"

RDEPENDS_PN = "spi-tools"

LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/LGPL-2.1;md5=1a6d268fd218675ffea8be556788b780"

SRC_URI += "file://activate_cellular.sh"
SRC_URI += "file://deactivate_cellular.sh"
SRC_URI += "file://keep_alive.sh"
SRC_URI += "file://keep_alive_init.sh"

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "keep_alive_init"
INITSCRIPT_PARAMS = "defaults 99"

do_install() {
  install -d ${D}${bindir}
  install -d ${D}${sysconfdir}/init.d
  install -m 0755 ${S}/activate_cellular.sh ${D}${bindir}/activate_cellular
  ln -s activate_cellular ${D}${bindir}/activate_umts
  install -m 0755 ${S}/deactivate_cellular.sh ${D}${bindir}/deactivate_cellular
  ln -s deactivate_cellular ${D}${bindir}/deactivate_umts
  install -m 0755 ${S}/keep_alive.sh ${D}${bindir}/keep_alive
  install -m 0755 ${S}/keep_alive_init.sh ${D}${sysconfdir}/init.d/keep_alive_init
}
