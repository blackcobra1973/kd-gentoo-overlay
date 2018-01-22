# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="Common files for development of MATE desktop packages"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND=""

DOCS=( AUTHORS ChangeLog NEWS README README.doc-build doc/usage.txt
	doc/autogen.sh.example )

src_prepare() {
	eapply_user
	eautoreconf
}

src_install() {
	mv doc-build/README README.doc-build \
		|| die "Failed to rename doc-build/README"
	default
}
