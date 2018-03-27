# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2

DESCRIPTION="Calculator for MATE Desktop, a fork of gnome-calculator"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="dev-libs/atk:0
	>=dev-libs/glib-2.50.0:2
	dev-libs/libxml2:2
	>=x11-libs/gtk+-3.22:3
	x11-libs/pango:0"
DEPEND="${COMMON_DEPEND}
	>=app-text/yelp-tools-3.1.1:0
	>=dev-util/intltool-0.35.0:*
	mate-base/mate-common:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"
RDEPEND=${COMMON_DEPEND}

DOCS=( AUTHORS NEWS README.md )

src_prepare(){
	eapply_user
	eautoreconf
}