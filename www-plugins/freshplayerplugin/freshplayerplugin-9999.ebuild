# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

CMAKE_MIN_VERSION="2.8.8"

inherit cmake-utils eutils git-r3 multilib

DESCRIPTION="PPAPI-host NPAPI-plugin adapter for flashplayer in npapi based browsers"
HOMEPAGE="https://github.com/i-rinat/freshplayerplugin"
EGIT_REPO_URI="https://github.com/i-rinat/${PN}.git"

LICENSE="MIT"
SLOT=0
KEYWORDS=""
IUSE="jack libav pulseaudio vaapi vdpau"

HWDEC_DEPEND="x11-libs/libva
	x11-libs/libvdpau
	libav? ( media-video/libav:0=[vaapi?,vdpau?,x264] )
	!libav? ( media-video/ffmpeg:0=[vaapi?,vdpau?,x264] )"
COMMON_DEPEND="dev-libs/glib:2=
	dev-libs/icu:0
	dev-libs/libconfig:=
	dev-libs/libevent:=[threads]
	|| ( dev-libs/openssl:0
		dev-libs/libressl )
	media-libs/alsa-lib:=
	media-libs/freetype:2=
	media-libs/libv4l:0=
	media-libs/mesa:=[egl,gles2]
	|| ( x11-libs/gtk+:2
		x11-libs/gtk+:3 )
	x11-libs/libXrandr:=
	x11-libs/libXrender:=
	x11-libs/libdrm:=
	x11-libs/pango:=[X]
	jack? ( virtual/jack )
	pulseaudio? ( media-sound/pulseaudio )
	vaapi? ( ${HWDEC_DEPEND} )
	vdpau? ( ${HWDEC_DEPEND} )"
DEPEND="${COMMON_DEPEND}
	dev-util/ragel
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	www-plugins/adobe-flash:22[abi_x86_64,ppapi(+)]"


DOCS=( ChangeLog README.md )
PATCHES=( "${FILESDIR}/0.2.4-cmake.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with jack JACK)
		$(cmake-utils_use_with pulseaudio PULSEAUDIO)
		-DCMAKE_SKIP_RPATH=1
	)
	if use vaapi || use vdpau ; then
		mycmakeargs+=( -DWITH_HWDEC=1 )
	else
		mycmakeargs+=( -DWITH_HWDEC=0 )
	fi
	cmake-utils_src_configure
}

src_install() {
	exeinto /usr/$(get_libdir)/nsbrowser/plugins
	doexe "${BUILD_DIR}/libfreshwrapper-flashplayer.so"
	insinto /etc/
	mv data/freshwrapper.conf.example freshwrapper.conf
	doins freshwrapper.conf
	einstalldocs
}