# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2

DESCRIPTION="Default icon themes of MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=x11-themes/hicolor-icon-theme-0.10"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40:0
	>=x11-misc/icon-naming-utils-0.8.7:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="binchecks strip"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure --enable-icon-mapping
}
