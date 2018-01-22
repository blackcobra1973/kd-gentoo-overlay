# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Virtual Keyboard for X Window System"
HOMEPAGE="http://homepage3.nifty.com/tsato/xvkbd/"
SRC_URI="http://homepage3.nifty.com/tsato/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-libs/libXaw3d
	"
DOCS=( README )

src_compile() {
	xmkmf
	default
}

src_install() {
	default
	emake DESTDIR="${D}" install.man
	domenu "${FILESDIR}/xvkbd.desktop"
}
