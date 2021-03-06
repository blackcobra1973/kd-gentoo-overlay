# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Several extensions for Caja file manager"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

SENDTO="cdr drive gajim mail pidgin upnp"
IUSE="${SENDTO} debug gksu image-converter +open-terminal share wallpaper"
REQUIRED_USE="gksu? ( open-terminal )"

COMMON_DEPEND=">=dev-libs/glib-2.50.0:2
	>=mate-base/caja-1.17.1:0
	virtual/libintl:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.22.0:3
	gajim? ( net-im/gajim:0
		>=dev-libs/dbus-glib-0.60:0
		>=sys-apps/dbus-1.0:0 )
	open-terminal? ( >=mate-base/mate-desktop-1.17.0:0 )
	pidgin? ( >=dev-libs/dbus-glib-0.60:0 )
	upnp? ( >=net-libs/gupnp-0.13:0= )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-1.9:0
	>=dev-util/intltool-0.18:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}
	gksu? ( x11-libs/gksu:0 )
	image-converter? ( || ( media-gfx/imagemagick
		media-gfx/graphicsmagick[imagemagick] ) )"

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
	if use cdr || use drive || use mail || use pidgin || use gajim || use upnp ; then
		MY_CONF="--enable-sendto --with-sendto-plugins="
		use cdr && MY_CONF="${MY_CONF},caja-burn"
		use drive && MY_CONF="${MY_CONF},removable-devices"
		use mail && MY_CONF="${MY_CONF},emailclient"
		use pidgin && MY_CONF="${MY_CONF},pidgin"
		use gajim && MY_CONF="${MY_CONF},gajim"
		use upnp && MY_CONF="${MY_CONF},upnp"
	else
		MY_CONF="--disable-sendto"
	fi

	gnome2_src_configure ${MY_CONF} \
		$(use_enable gksu) \
		$(use_enable image-converter) \
		$(use_enable open-terminal) \
		$(use_enable share) \
		$(use_enable wallpaper)
}
