# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_7 )

inherit autotools git-r3 gnome2 python-r1

DESCRIPTION="MATE library to access weather information from online services"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug"

COMMON_DEPEND=">=dev-libs/glib-2.36.0:2[${PYTHON_USEDEP}]
	>=dev-libs/libxml2-2.6.0:2
	>=net-libs/libsoup-2.34.0:2.4
	>=sys-libs/timezone-data-2010k:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.14.0:3
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50.1:0
	mate-base/mate-common:0
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
		--enable-locations-compression \
		--disable-all-translations-in-one-xml
}

src_compile() {
	gnome2_src_compile
}

src_install() {
	gnome2_src_install
}
