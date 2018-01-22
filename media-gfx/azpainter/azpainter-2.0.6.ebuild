# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

OSDN_DIR="67805"

DESCRIPTION="A full-color painting software"
HOMEPAGE="http://azsky2.html.xdomain.jp/linux/azpainter/"
SRC_URI="mirror://osdn/${PN}/${OSDN_DIR}/${P}.tar.bz2"

LICENSE="GPL-3 BSD"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	media-libs/libpng:*
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

DOCS=( ChangeLog NEWS README README_ja html translation )

src_prepare() {
	default
	mv manual html
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}