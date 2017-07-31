DESCRIPTION = "Reading and writing registers off SPI devices"
HOMEPAGE = "http://www.sitec-systems.de"
MAINTAINER = "Robert Lehmann <robert.lehmann@sitec-systems.de>"

LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/LGPL-2.1;md5=1a6d268fd218675ffea8be556788b780"

PR = "r0"

inherit insane

SRC_URI += "file://Makefile"
SRC_URI += "file://spi_write.c"
SRC_URI += "file://spi_read.c"

S = "${WORKDIR}"

do_compile() {
  cd ${S}
  oe_runmake all
}

do_install() {
  install -d ${D}${bindir}/
  install -m 0755 ${S}/spi_write ${D}${bindir}/spi_write
  install -m 0755 ${S}/spi_read ${D}${bindir}/spi_read
}
