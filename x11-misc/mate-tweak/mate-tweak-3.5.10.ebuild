# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{3,4,5} )

inherit distutils-r1

HASH="22374775981c"
DESCRIPTION="MATE desktop tweak tool"
HOMEPAGE="https://launchpad.net/ubuntu/+source/mate-tweak"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2+"
KEYWORDS="~amd64"
SLOT="0"
IUSE="nls"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	nls? ( sys-devel/gettext ) "
RDEPEND="dev-libs/glib:2
	dev-python/psutil
	gnome-base/dconf
	mate-base/caja
	mate-base/mate-panel
	mate-extra/mate-media
	sys-process/psmisc
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2"

S="${WORKDIR}/ubuntu-mate-${PN}-${HASH}"
RESTRICT="mirror"