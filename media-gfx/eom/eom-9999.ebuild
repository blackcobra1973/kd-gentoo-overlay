# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit autotools git-r3 gnome2 python-single-r1

DESCRIPTION="Image viewer for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X dbus debug doc exif +gtk3 introspection jpeg lcms -python svg tiff xmp"
REQUIRED_USE="gtk3? ( !python )
	python? ( ${PYTHON_REQUIRED_USE} )"

COMMON_DEPEND="dev-libs/atk:0[introspection?]
	>=dev-libs/glib-2.36.0:2
	dev-libs/libpeas:0
	>=dev-libs/libxml2-2.0:2
	gnome-base/dconf:0
	gnome-base/gsettings-desktop-schemas:0[introspection?]
	>=mate-base/mate-desktop-1.9.1:0[gtk3(+)=,introspection?]
	sys-libs/zlib:0
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.30.0:2[introspection?,jpeg?,tiff?]
	x11-libs/libX11:0
	>=x11-misc/shared-mime-info-0.20:0
	virtual/libintl:0
	dbus? ( >=dev-libs/dbus-glib-0.71:0 )
	exif? ( >=media-libs/libexif-0.6.14:0
		virtual/jpeg:0 )
	!gtk3? ( >=x11-libs/gtk+-2.18.0:2[introspection?] )
	gtk3? ( >=x11-libs/gtk+-3.14.0:3[introspection?] )
	introspection? ( >=dev-libs/gobject-introspection-0.9.3:0 )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-2.15.1:2[${PYTHON_USEDEP}]
		>=dev-python/pygtk-2.13.0:2[${PYTHON_USEDEP}] )
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

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

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
		--with-gtk=$(usex gtk3 '3.0' '2.0') \
		$(use_enable introspection) \
		$(use_with jpeg libjpeg) \
		$(use_with lcms cms) \
		$(use_enable python) \
		$(use_with svg librsvg) \
		$(use_with xmp)
}
