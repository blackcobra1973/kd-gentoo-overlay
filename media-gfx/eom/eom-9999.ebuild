# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2

DESCRIPTION="Image viewer for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X dbus debug doc exif introspection jpeg lcms svg tiff xmp"

COMMON_DEPEND="dev-libs/atk:0[introspection?]
	>=dev-libs/glib-2.50.0:2
	>=dev-libs/libpeas-1.2.0:0
	>=dev-libs/libxml2-2.0:2
	gnome-base/dconf:0
	gnome-base/gsettings-desktop-schemas:0[introspection?]
	>=mate-base/mate-desktop-1.17.0:0[introspection?]
	sys-libs/zlib:0
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.30.0:2[introspection?,jpeg?,tiff?]
	>=x11-libs/gtk+-3.22.0:3[introspection?]
	x11-libs/libX11:0
	>=x11-misc/shared-mime-info-0.20:0
	virtual/libintl:0
	dbus? ( >=dev-libs/dbus-glib-0.71:0 )
	exif? ( >=media-libs/libexif-0.6.14:0
		virtual/jpeg:0 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.3:0 )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	svg? ( >=gnome-base/librsvg-2.36.2:2 )
	xmp? ( >=media-libs/exempi-1.99.5:2 )"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools:0
	>=dev-util/gtk-doc-1.9
	>=dev-util/intltool-0.50.1:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
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
		--without-cms \
		$(use_with X x) \
		$(use_with dbus) \
		$(use_with exif libexif) \
		$(use_enable introspection) \
		$(use_with jpeg libjpeg) \
		$(use_with lcms cms) \
		$(use_with svg librsvg) \
		$(use_with xmp)
}
