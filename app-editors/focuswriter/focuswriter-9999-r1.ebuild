# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="af_ZA ar ca cs da de el en en_GB eo es es_MX fi fr he hu hy id it ja
	ko lt nl pl pt pt_BR ro ru sk sr sv tr uk vi zh_CN"
PLOCALE_BACKUP="en"

inherit fdo-mime git-r3 gnome2-utils l10n qmake-utils

DESCRIPTION="A fullscreen and distraction-free word processor"
HOMEPAGE="http://gottcode.org/focuswriter/"
EGIT_REPO_URI="https://github.com/gottcode/focuswriter.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"

COMMON_DEPEND="app-text/hunspell:=
	>=dev-qt/qtconcurrent-5.2:5
	>=dev-qt/qtcore-5.2:5
	>=dev-qt/qtgui-5.2:5
	>=dev-qt/qtmultimedia-5.2:5
	>=dev-qt/qtnetwork-5.2:5
	>=dev-qt/qtprintsupport-5.2:5
	dev-qt/qtsingleapplication[X,qt5]
	>=dev-qt/qtwidgets-5.2:5
	sys-libs/zlib"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}

DOCS=( CREDITS NEWS README )

PATCHES=( "${FILESDIR}/${PN}-1.5.2-unbundle-qtsingleapplication.patch" )

rm_loc() {
	sed -e "s|translations/${PN}_${1}.ts||"	-i ${PN}.pro || die 'sed failed'
	rm translations/${PN}_${1}.ts || die "removing ${1} locale failed"
}

src_prepare() {
	l10n_for_each_disabled_locale_do rm_loc
	eapply_user
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update

	elog ' Focuswriter has optional sound support if media-libs/sdl-mixer is'
	elog 'installed with wav useflag enabled.'

}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
