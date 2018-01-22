# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

ELTCONF="--portage"

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Atril document viewer for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="caja dbus debug djvu doc dvi epub +introspection gnome-keyring +pdf +ps
	t1lib tiff xps"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/glib-2.36.0:2
	>=dev-libs/libxml2-2.5.0:2
	sys-libs/zlib:0
	x11-libs/gdk-pixbuf:2[introspection?]
	>=x11-libs/gtk+-3.0.0:3[introspection?]
	x11-libs/libICE:0
	>=x11-libs/libSM-1:0
	x11-libs/libX11:0
	>=x11-libs/cairo-1.9.10:0
	x11-libs/pango:0
	caja? ( mate-base/caja[gtk3(+),introspection?] )
	djvu? ( >=app-text/djvu-3.5.17:0 )
	dvi? ( virtual/tex-base:0
		t1lib? ( >=media-libs/t1lib-5:5 ) )
	epub? ( dev-libs/mathjax
		|| ( net-libs/webkit-gtk:4
			net-libs/webkit-gtk:3 ) )
	gnome-keyring? ( >=app-crypt/libsecret-0.5:0 )
	introspection? ( >=dev-libs/gobject-introspection-0.6:0 )
	pdf? ( >=app-text/poppler-0.22.0:0=[cairo] )
	ps? ( >=app-text/libspectre-0.2.0:0 )
	tiff? ( >=media-libs/tiff-3.6:0 )
	xps? ( >=app-text/libgxps-0.2.0:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=app-text/scrollkeeper-dtd-1:1.0
	>=dev-util/intltool-0.50.1:0
	virtual/pkgconfig:0
	sys-devel/gettext:0
	doc? ( >=dev-util/gtk-doc-1.13:0 )"
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
	# Passing --disable-help would drop offline help, that would be inconsistent
	# with helps of the most of GNOME apps that doesn't require network for that.
	gnome2_src_configure \
		--disable-tests \
		--enable-comics \
		--enable-pixbuf \
		--enable-thumbnailer \
		--with-smclient=xsmp \
		--with-platform=mate \
		$(use_enable caja) \
		$(use_enable dbus) \
		$(use_enable djvu) \
		$(use_enable doc gtk-doc) \
		$(use_enable dvi) \
		$(use_enable epub) \
		$(use_with gnome-keyring keyring) \
		$(use_enable introspection) \
		$(use_enable pdf) \
		$(use_enable ps) \
		$(use_enable t1lib) \
		$(use_enable tiff) \
		$(use_enable xps)
}

pkg_postinst() {
	elog "For viewing comic books (CBR files),"
	elog "Please note uncompressors such as app-arch/unrar may be needed."
}