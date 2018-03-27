# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2

DESCRIPTION="Multimedia related programs for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2 GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS=""
IUSE="debug"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/libxml2:2
	>=dev-libs/glib-2.50.0:2
	>=mate-base/mate-desktop-1.17.0:0
	>=media-libs/libcanberra-0.13:0[gtk3]
	>=media-libs/libmatemixer-1.10.0:0
	x11-libs/cairo:0
	>=x11-libs/gtk+-3.22.0:3
	x11-libs/pango:0
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=app-text/scrollkeeper-dtd-1:1.0
	>=dev-util/intltool-0.35.0:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}
	x11-themes/sound-theme-freedesktop"

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}
