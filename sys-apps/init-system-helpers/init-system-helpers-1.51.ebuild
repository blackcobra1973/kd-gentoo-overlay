# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Helper tools for all init systems"
HOMEPAGE="https://packages.debian.org/sid/init-system-helpers"
SRC_URI="http://http.debian.net/debian/pool/main/i/${PN}/${PN}_${PV}.tar.xz"

LICENSE="BSD GPL-2+"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/docutils"
RDEPEND="!<sys-apps/openrc-0.33"

RESTRICT="mirror"

src_prepare() {
	# Replace VERSION with the current one
	sed -i -e 's/__VERSION__/'${PV}'/' script/service

	# update_openrc_started_symlinks is not needed any more
	sed -i -e '/^update_openrc_started_symlinks$/d' script/service

	# Fix a very trivial typo
	sed -i -e '/^:Version:/s/206/2006/' man8/service.rst

	default
}

src_compile() {
	# Compile manuals
	rst2man.py man8/invoke-rc.d.rst man8/invoke-rc.d.8
	rst2man.py man8/service.rst man8/service.8
	rst2man.py man8/update-rc.d.rst man8/update-rc.d.8
}

src_install() {
	exeinto /sbin/
	# script/deb-* for Debian users are not needed
	doexe script/invoke-rc.d script/service script/update-rc.d
	doman man8/invoke-rc.d.8 man8/service.8 man8/update-rc.d.8
}