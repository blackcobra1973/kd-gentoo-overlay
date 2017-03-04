# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit eutils multilib autotools user toolchain-funcs

DESCRIPTION="The Yadifa DNS Daemon"
#SRC_URI="http://cdn.yadifa.eu/sites/default/files/releases/yadifa-1.0.1-2116.tar.gz"
SRC_URI="http://cdn.yadifa.eu/sites/default/files/releases/${P}.tar.gz"
HOMEPAGE="http://www.yadifa.eu/"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

## Dev
#IUSE="footprint acl tsig nsec3 nsec mirror dropall messages static"

##Prod
IUSE="footprint messages static"

src_configure() {
    local myconf=""

    use footprint && myconf="${myconf} --enable-tiny-footprint"
    use acl && myconf="${myconf} --disable-acl"
    use tsig && myconf="${myconf} --disable-tsig"
    use nsec3 && myconf="${myconf} --disable-nsec3"
    use nsec && myconf="${myconf} --disable-nsec"
    use mirror && myconf="${myconf} --enable-mirror"
    use dropall && myconf="${myconf} --enable-dropall"
    use messages && myconf="${myconf} --enable-messages"

    econf \
        --sysconfdir=/etc/yadifa \
        --libdir=/usr/$(get_libdir)/yadifa \
        --localstatedir=/var \
        $(use_enable static static-binaries) \
        ${myconf} \
        || die "econf failed"
}

