# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Library with common API for various MATE modules"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X debug doc introspection startup-notification"

COMMON_DEPEND=">=dev-libs/glib-2.50:2
	>=gnome-base/dconf-0.13.4:0
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.4:2[introspection?]
	>=x11-libs/gtk+-3.22.0:3[introspection?]
	x11-libs/libX11:0
	>=x11-libs/libXrandr-1.3:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.9.7:0 )
	startup-notification? ( >=x11-libs/startup-notification-0.5:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=dev-util/intltool-0.50.1:0
	>=gnome-base/dconf-0.10:0
	sys-devel/gettext:0
	|| ( x11-base/xorg-proto
		( >=x11-proto/randrproto-1.2:0
			x11-proto/xproto:0 ) )
	virtual/pkgconfig:0
	doc? ( >=dev-util/gtk-doc-1.4:0 )"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

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
		--enable-mate-about \
		$(use_with X x) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable startup-notification)
}