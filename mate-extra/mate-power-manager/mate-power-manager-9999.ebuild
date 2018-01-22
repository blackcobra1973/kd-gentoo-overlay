# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2

DESCRIPTION="Session daemon for MATE desktop, acts as a policy agent of UPower"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+applet gnome-keyring man policykit test"

RESTRICT="test"

COMMON_DEPEND="app-text/rarian:0
	>=dev-libs/dbus-glib-0.70:0
	>=dev-libs/glib-2.36.0:2
	>=media-libs/libcanberra-0.10:0[gtk3]
	>=sys-apps/dbus-1.0:0
	>=sys-auth/consolekit-1.0
	>=x11-apps/xrandr-1.3.0:0
	>=x11-libs/cairo-1.0.0:0
	>=x11-libs/gdk-pixbuf-2.11:2
	>=x11-libs/gtk+-3.14.0:3
	x11-libs/libX11:0
	x11-libs/libXext:0
	>=x11-libs/libXrandr-1.3.0:0
	>=x11-libs/libnotify-0.7.0:0
	x11-libs/pango:0
	applet? ( >=mate-base/mate-panel-1.5.0:0[gtk3(+)] )
	gnome-keyring? ( >=gnome-base/libgnome-keyring-3.0.0:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.3
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	>=dev-util/intltool-0.50.1:0
	x11-proto/randrproto:0
	>=x11-proto/xproto-7.0.15:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	man? ( app-text/docbook-sgml-utils:0
		app-text/docbook-sgml-dtd:4.3 )"
RDEPEND="${COMMON_DEPEND}
	policykit? ( ~mate-extra/mate-polkit-9999 )"

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
		--enable-compile-warnings=minimum \
		$(use_enable applet applets) \
		$(use_with gnome-keyring keyring) \
		$(use_enable test tests)
}