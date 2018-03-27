# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Meta package for MATE panel applets"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/mate-applets"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS=""
IUSE="appindicator sensors"

DEPEND=""
RDEPEND="~mate-base/mate-applets-9999
	appindicator? ( ~mate-extra/mate-indicator-applet-9999 )
	sensors? ( ~mate-extra/mate-sensors-applet-9999 )"