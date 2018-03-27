# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Utilities of MATE desktop for netbooks"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"

COMMON_DEPEND=">=dev-libs/glib-2.50:2
	>=mate-base/mate-panel-1.17.0:0
	x11-libs/cairo:0
	>=x11-libs/gtk+-3.22.0:3
	x11-libs/libwnck:1
	x11-libs/libfakekey:0
	x11-libs/libXtst:0
	x11-libs/libX11:0
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50.1:*
	sys-devel/gettext:*
	virtual/pkgconfig:*
	|| ( x11-base/xorg-proto
		x11-proto/xproto:0 )"
RDEPEND=${COMMON_DEPEND}

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}
