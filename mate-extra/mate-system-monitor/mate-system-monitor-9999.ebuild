# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2

DESCRIPTION="The MATE System Monitor"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="systemd"

COMMON_DEPEND="app-text/rarian:0
	>=dev-cpp/glibmm-2.16:2
	>=dev-cpp/gtkmm-3.8.1:3.0
	>=dev-libs/glib-2.50:2
	dev-libs/libsigc++:2
	>=dev-libs/libxml2-2:2
	>=gnome-base/libgtop-2.23.1:2=
	>=gnome-base/librsvg-2.12:2
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.22.0:3
	>=x11-libs/libwnck-3.4.0:3
	virtual/libintl:0
	systemd? ( >=sys-apps/systemd-44 )"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
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
		$(use_enable systemd)
}

pkg_postinst() {
        gnome2_pkg_postinst

        einfo "To kill or renice processes with root privilege,"
        einfo "please install sys-auth/polkit or x11-libs/gksu"
}