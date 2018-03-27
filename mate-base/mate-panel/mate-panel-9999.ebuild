# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Panel, library and several applets for the MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X +introspection"

COMMON_DEPEND="dev-libs/atk:0[introspection?]
	>=dev-libs/dbus-glib-0.80:0
	>=dev-libs/glib-2.50.0:2
	>=dev-libs/libmateweather-1.17.0:0
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.13.4:0
	>=gnome-base/librsvg-2.36.2:2
	>=mate-base/mate-desktop-1.17.0:0[introspection?]
	>=mate-base/mate-menus-1.10:0
	>=sys-apps/dbus-1.1.2:0
	>=x11-libs/cairo-1.0.0:0
	>=x11-libs/gdk-pixbuf-2.7.1:2[introspection?]
	>=x11-libs/gtk+-3.22.0:3[introspection?]
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	>=x11-libs/libwnck-3.4.0:3[introspection?]
	>=x11-libs/pango-1.15.4:0[introspection?]
	x11-libs/libXau:0
	>=x11-libs/libXrandr-1.3.0:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=dev-lang/perl-5:0=
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.50.1:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--libexecdir=/usr/libexec/mate-applets \
		--disable-deprecation-flags \
		$(use_with X x) \
		$(use_enable introspection)
}

pkg_postinst() {
	elog \
	"Note: x11-misc/mozo or x11-misc/menulibre is needed to launch menu editor"
}
