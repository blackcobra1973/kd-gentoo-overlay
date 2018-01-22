# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools eutils fdo-mime gnome2-utils

MY_PN="Viewnior"

DESCRIPTION="Fast and simple image viewer"
HOMEPAGE="http://xsisqox.github.com/Viewnior/index.html"
SRC_URI="https://github.com/xsisqox/${MY_PN}/archive/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-libs/glib-2.32:2
	>=media-gfx/exiv2-0.21:=
	>=x11-libs/gtk+-2.20:2
	>=x11-misc/shared-mime-info-0.20"
RDEPEND="${DEPEND}
	x11-libs/gdk-pixbuf:2"

S="${WORKDIR}/${MY_PN}-${P}"

DOCS="AUTHORS ChangeLog* NEWS README TODO"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.5-background-mate-cinnamon.patch"
	eautoreconf
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}