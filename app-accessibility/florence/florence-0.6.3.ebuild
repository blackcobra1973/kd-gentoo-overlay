# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit gnome2-utils

DESCRIPTION="an extensible scalable virtual keyboard for X11"
HOMEPAGE="http://florence.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc libnotify"

COMMON_DEPEND=">=dev-libs/libxml2-2.0
	gnome-base/gconf:2
	>=gnome-base/libglade-2.0
	gnome-base/librsvg
	media-libs/gstreamer:1.0
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libXtst
	doc? ( app-text/gnome-doc-utils )
	libnotify? ( x11-libs/libnotify )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.23
	sys-devel/gettext"
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

DOCS=( README NEWS )

src_configure() {
	econf \
		--with-xtst \
		$(use_with doc docs ) \
		$(use_with libnotify notification )
}

src_compile() {
	emake -j1
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
