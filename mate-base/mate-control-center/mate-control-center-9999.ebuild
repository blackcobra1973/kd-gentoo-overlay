# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Configuration tool for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="appindicator debug +gtk3"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/dbus-glib-0.73:0
	dev-libs/glib:2
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.13.4:0
	>=gnome-base/librsvg-2.0:2
	>=mate-base/libmatekbd-1.1.0:0[gtk3(+)=]
	>=mate-base/mate-desktop-1.15.0:0[gtk3(+)=]
	>=mate-base/caja-1.13.0:0[gtk3(+)=]
	>=mate-base/mate-menus-1.1.0:0
	>=mate-base/mate-settings-daemon-1.13.1:0[gtk3(+)=]
	>=media-libs/fontconfig-1:1.0
	media-libs/freetype:2
	>=sys-apps/dbus-1:0
	x11-apps/xmodmap:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/libX11:0
	x11-libs/libXScrnSaver:0
	x11-libs/libXcursor:0
	x11-libs/libXext:0
	x11-libs/libXft:0
	>=x11-libs/libXi-1.2:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/libXxf86misc:0
	>=x11-libs/libxklavier-4:0
	x11-libs/pango:0
	>=x11-wm/marco-1.13.1[gtk3(+)=]
	virtual/libintl:0
	appindicator? ( !gtk3? ( >=dev-libs/libappindicator-0.0.13:2 )
		gtk3? ( >=dev-libs/libappindicator-0.0.13:3 ) )
	!gtk3? ( >=dev-libs/libunique-1.0:1
		media-libs/libcanberra:0[gtk]
		>=x11-libs/gtk+-2.24.0:2 )
	gtk3? ( media-libs/libcanberra:0[gtk3]
		>=x11-libs/gtk+-3.14.0:3 )"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	dev-util/desktop-file-utils:0
	>=dev-util/intltool-0.50.1:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	x11-proto/kbproto:0
	x11-proto/randrproto:0
	x11-proto/renderproto:0
	x11-proto/scrnsaverproto:0
	x11-proto/xextproto:0
	x11-proto/xf86miscproto:0
	x11-proto/xproto:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

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
		--disable-update-mimedb \
		$(use_enable appindicator) \
		--with-gtk=$(usex gtk3 '3.0' '2.0')
}
