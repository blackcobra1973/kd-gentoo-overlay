# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Engrampa archive manager for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="caja debug"

COMMON_DEPEND=">=dev-libs/glib-2.32.0:2
	>=dev-libs/json-glib-0.14:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.14.0:3
	x11-libs/pango:0
	virtual/libintl:0
	caja? ( >=mate-base/caja-1.17.1:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50.1:0
	dev-util/itstool:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS HACKING NEWS README README-DISTRIBUTIONS )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-run-in-place \
		--disable-packagekit \
		--disable-deprecations \
		$(use_enable caja caja-actions)
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog ""
	elog "${PN} is a frontend for several archiving utilities. If you want a"
	elog "particular achive format supported install the relevant package."
	elog
	elog "For example:"
	elog "  7-zip   : emerge app-arch/p7zip"
	elog "  ace     : emerge app-arch/unace"
	elog "  arj     : emerge app-arch/arj"
	elog "  cpio    : emerge app-arch/cpio"
	elog "  deb     : emerge app-arch/dpkg"
	elog "  iso     : emerge app-cdr/cdrtools"
	elog "  jar,zip : emerge app-arch/zip  or  emerge app-arch/unzip"
	elog "  lha     : emerge app-arch/lha"
	elog "  lzma    : emerge app-arch/xz-utils"
	elog "  lzop    : emerge app-arch/lzop"
	elog "  rar     : emerge app-arch/unrar"
	elog "  rpm     : emerge app-arch/rpm"
	elog "  unstuff : emerge app-arch/stuffit"
	elog "  zoo     : emerge app-arch/zoo"
}
