# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Utilities for the MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2.1+"
SLOT="0"
KEYWORDS=""
IUSE="X applet debug ipv6 test"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/glib-2.50.0:2
	>=gnome-base/libgtop-2.12.0:2=
	>=media-libs/libcanberra-0.4:0[gtk3]
	sys-libs/zlib:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.22.0:3
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	x11-libs/libXext:0
	x11-libs/pango:0
	applet? ( >=mate-base/mate-panel-1.17.0:0 )"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	>=dev-util/intltool-0.50.1:0
	mate-base/mate-common:0
	|| ( x11-base/xorg-proto
		x11-proto/xextproto:0 )
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README THANKS )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare

	if ! use test; then
		sed -e 's/ tests//' -i logview/Makefile.{am,in} || die
	fi
}

src_configure() {
	local myconf
	if ! use debug; then
		myconf="${myconf} --enable-debug=minimum"
	fi

	gnome2_src_configure \
		--disable-maintainer-flags \
		--enable-zlib \
		$(use_with X x) \
		$(use_enable applet gdict-applet) \
		$(use_enable ipv6) \
		${myconf}
}
