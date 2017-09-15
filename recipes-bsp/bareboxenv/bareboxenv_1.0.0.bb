DESCRIPTION = "Bareboxenvironment Utility"
HOMEPAGE = "http://www.sitec-systems.de"
MAINTAINER = "Robert Lehmann <robert.lehmann@sitec-systems.de>"
LICENSE = "CLOSED"

PR = "r0"

SRC_URI = "file://env/"
SRC_URI += "file://bareboxenv-target"
SRC_URI += "file://bareboxenv-restore.sh"
SRC_URI += "file://bareboxenv.sh"
S = "${WORKDIR}"

INSANE_SKIP_${PN} = "already-stripped ldflags"

do_unpack() {
    cp ${THISDIR}/files/bareboxenv-target ${S}
    cp ${THISDIR}/files/bareboxenv-restore.sh ${S}
    cp ${THISDIR}/files/bareboxenv.sh ${S}
    cd ${THISDIR}/files/env && tar -czf ${S}/env.tar.gz *
}

do_install() {
    install -d ${D}/usr/bin
    install -d ${D}/usr/share/barebox

    install -m 0755 ${S}/bareboxenv-target ${D}/usr/bin
    install -m 0755 ${S}/bareboxenv.sh ${D}/usr/bin/bareboxenv
    install -m 0755 ${S}/bareboxenv-restore.sh ${D}/usr/bin/bareboxenv-restore
    install -m 0644 ${S}/env.tar.gz ${D}/usr/share/barebox/env.tar.gz
}

FILES_${PN} = "*"