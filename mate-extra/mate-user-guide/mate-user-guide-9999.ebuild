# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="Documents for end-users of MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="FDL-1.1+"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-util/intltool-0.40.0:0
	app-text/yelp-tools:0
	sys-devel/gettext:0"
RDEPEND=""

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

src_prepare() {
	eapply_user
	eautoreconf
}

pkg_postinst(){
	elog "To browse the documents, please install gnome-extra/yelp"
}
