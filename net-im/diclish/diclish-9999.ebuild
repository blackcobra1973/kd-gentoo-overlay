# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="CLI bash script for posting/reading on Diaspora* pod"
HOMEPAGE="https://notabug.org/uzver/diclish"
SRC_URI=""
EGIT_REPO_URI="https://notabug.org/uzver/diclish.git"
LICENSE="WTFPL-2"

SLOT="0"
KEYWORDS=""
DEPEND=""
RDEPEND="app-misc/jq
	app-shells/bash
	net-misc/curl"

DOCS=( INSTALL.md README.md )

RESTRICT="mirror"

src_install() {
	dobin diclish
	dodoc "${DOCS[@]}"
}
