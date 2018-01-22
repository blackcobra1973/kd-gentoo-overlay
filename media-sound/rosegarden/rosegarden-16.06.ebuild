# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils fdo-mime gnome2-utils

DESCRIPTION="MIDI and audio sequencer and notation editor"
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="lirc qt4 +qt5"
REQUIRED_USE="^^ ( qt5 qt4 )"

COMMON_DEPEND="
	>=media-libs/alsa-lib-0.9:=
	>=media-libs/dssi-1.0.0:=
	media-libs/ladspa-sdk:=
	>=media-libs/liblo-0.7:=
	>=media-libs/liblrdf-0.2:=
	>=media-libs/libsamplerate-0.1.2:=[sndfile]
	>=media-libs/libsndfile-1.0.16:=
	>=sci-libs/fftw-3.0.0:3.0
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libX11
	virtual/jack
	lirc? ( app-misc/lirc:= )
	qt4? ( >=dev-qt/qtcore-4.8.0:4
		>=dev-qt/qtgui-4.8.0:4
		>=dev-qt/qtnetwork-4.8.0:4
		>=dev-qt/qttest-4.8.0:4
		>=dev-qt/qtxml-4.8.0:4 )
	qt5? ( >=dev-qt/qtcore-5.1.0:5
		>=dev-qt/qtgui-5.1.0:5
		>=dev-qt/qtnetwork-5.1.0:5
		>=dev-qt/qtprintsupport-5.1.0:5
		>=dev-qt/qttest-5.1.0:5
		>=dev-qt/qtwidgets-5.1.0:5
		>=dev-qt/qtxml-5.1.0:5 )
"
DEPEND="${COMMON_DEPEND}
	dev-util/cmake
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="mirror"

src_configure() {
	local mycmakeargs=(
		$(usex lirc '-DDISABLE_LIRC=OFF' '-DDISABLE_LIRC=ON')	
		$(usex qt4 '-DUSE_QT4=ON' '-DUSE_QT4=OFF')
		$(usex qt5 '-DUSE_QT5=ON' '-DUSE_QT5=OFF')
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
