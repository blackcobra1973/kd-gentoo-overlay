# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Applet to display information from applications in MATE panel"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=dev-libs/glib-2.2.0:2
	>=dev-libs/libindicator-0.3.90:3
	>=mate-base/mate-panel-1.17.0
	>=x11-libs/gtk+-3.14.0:3
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35.0:0
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
		--disable-static
}
