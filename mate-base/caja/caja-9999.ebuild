# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Caja file manager for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS=""
IUSE="debug doc +introspection xmp"

COMMON_DEPEND="dev-libs/atk:0[introspection?]
	>=dev-libs/glib-2.36.0:2
	>=dev-libs/libxml2-2.4.7:2
	gnome-base/dconf:0
	>=gnome-base/gvfs-1.10.1:0[udisks]
	>=mate-base/mate-desktop-1.17.0:0
	>=media-libs/libexif-0.6.14:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.14.0:3[introspection?]
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	x11-libs/libXext:0
	x11-libs/libXft:0
	x11-libs/libXrender:0
	>=x11-libs/libnotify-0.7.0:0
	>=x11-libs/pango-1.1.2:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.4:0 )
	xmp? ( >=media-libs/exempi-1.99.5:2 )"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/perl-5:0=
	dev-util/gdbus-codegen:0
	>=dev-util/intltool-0.50.1:0
	mate-base/mate-common:0
	sys-apps/sed:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	doc? ( >=dev-util/gtk-doc-1.4:0 )"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="test"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf

	# Remove unnecessary CFLAGS
	sed -i -e 's:-DG.*DISABLE_DEPRECATED::g' \
		configure{,.ac} eel/Makefile.{am,in} || die

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-unique \
		--disable-packagekit \
		--disable-update-mimedb \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable xmp)
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "You can add extentions by installing packages below"
	elog "- mate-extra/caja-extensions"
	elog "- dev-python/python-caja"
	elog "- mate-extra/caja-dropbox"
}
