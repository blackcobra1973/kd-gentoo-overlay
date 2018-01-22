# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2 multilib multilib-minimal

DESCRIPTION="A gdk-pixbuf loader for xcf (The Gimp) files"
HOMEPAGE="http://blog.reblochon.org/2009/03/gift-to-competition.html"
SRC_URI="https://gh.asis.li/files/gdk-pixbuf-xcf-2012.05.tar.xz"

LICENSE="LGPL-2+"
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
		--libdir=/usr/$(get_libdir)/gdk-pixbuf-2.0/2.10.0/loaders/ \
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
