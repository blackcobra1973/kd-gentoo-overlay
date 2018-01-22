# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2-utils

DESCRIPTION="A theme set for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

# LGPL-2.1+: Blue-Submarine
# GPL-3:	 BlackMATE, BlueMenta, GreenLagna, Menta, TraditionalGreen,
#			 TraditionalOk, TraditionalOkTest
# Other:	 LGPL-2.1
LICENSE="LGPL-2.1 LGPL-2.1+ GPL-3"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=x11-libs/gdk-pixbuf-2.0.0:2
	|| ( ( >=x11-libs/gtk+-2.0.0:2
			>=x11-themes/gtk-engines-2.15.3:2
			x11-themes/gtk-engines-murrine )
		>=x11-libs/gtk+-3.16.0:3= )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35:0
	sys-devel/gettext:0
	>=x11-misc/icon-naming-utils-0.8.7:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="binchecks strip"

DOCS=( AUTHORS NEWS README )

pkg_setup(){
	# should select the appropriate branch for the installed GTK+:3 version
	if has_version '>=x11-libs/gtk+-3.21.9' ; then
		EGIT_BRANCH="gtk3.22"
	elif has_version '>=x11-libs/gtk+-3.20' ; then
		EGIT_BRANCH="gtk3.20"
	elif has_version '>=x11-libs/gtk+-3.18' ; then
		EGIT_BRANCH="gtk3.18"
	elif has_version '>=x11-libs/gtk+-3.16' ; then
		EGIT_BRANCH="gtk3.16"
	fi
}

src_prepare() {
	default
	eautoreconf
}

pkg_preinst() {
        gnome2_icon_savelist
}

pkg_postinst() {
        gnome2_icon_cache_update
}

pkg_postrm() {
        gnome2_icon_cache_update
}