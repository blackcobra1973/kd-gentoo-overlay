# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2 multilib multilib-minimal

DESCRIPTION="A GdkPixbuf loader for Adobe Photoshop images"
HOMEPAGE="http://cgit.sukimashita.com/gdk-pixbuf-psd.git/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="http://git.sukimashita.com/${PN}.git"
else
	SRC_URI="http://cgit.sukimashita.com/${PN}.git/snapshot/${P}.tar.bz2"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="-static"

COMMON_DEPEND=">=dev-libs/glib-2.0[${MULTILIB_USEDEP}]
	>=x11-libs/gdk-pixbuf-2.0[${MULTILIB_USEDEP}]"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

src_prepare() {
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" gnome2_src_configure \
		$(use_enable static)
}

multilib_src_install() {
	gnome2_src_install
}

pkg_preinst() {
	gnome2_gdk_pixbuf_savelist
}

pkg_postinst() {
	gnome2_gdk_pixbuf_update
}

pkg_postrm() {
	gnome2_gdk_pixbuf_update
}
