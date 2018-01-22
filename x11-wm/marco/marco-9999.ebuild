# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Default window manager of MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="startup-notification test xinerama"

COMMON_DEPEND="dev-libs/atk:0
	>=dev-libs/glib-2.36.0:2
	>=gnome-base/libgtop-2.0:2=
	gnome-extra/zenity:0
	media-libs/libcanberra:0[gtk3]
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	>=x11-libs/libXcomposite-0.3:0
	x11-libs/libXcursor:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/libxkbcommon:0
	>=x11-libs/gtk+-3.14.0:3
	>=x11-libs/pango-1.2.0:0[X]
	>=x11-libs/startup-notification-0.7:0
	virtual/libintl:0
	xinerama? ( x11-libs/libXinerama:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools:0
	>=dev-util/intltool-0.34.90:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	x11-proto/xextproto:0
	x11-proto/xproto:0
	test? ( app-text/docbook-xml-dtd:4.5 )
	xinerama? ( x11-proto/xineramaproto:0 )"
RDEPEND="${COMMON_DEPEND}"

DOCS="AUTHORS ChangeLog HACKING NEWS README *.txt doc/*.txt"

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
		--enable-compositor \
		--enable-render \
		--enable-shape \
		--enable-sm \
		--enable-xsync \
		$(use_enable startup-notification) \
		$(use_enable xinerama)
}
