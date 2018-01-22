# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="Image viewers for the framebuffer console (fbi) and X11 (ida)"
HOMEPAGE="http://www.kraxel.org/blog/linux/fbida/"
SRC_URI="
	http://www.kraxel.org/releases/${PN}/${P}.tar.gz
	mirror://gentoo/ida.png.bz2
"
LICENSE="GPL-2 IJG"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="curl fbcon +gif lirc pdf +png scanner +tiff X +webp"
REQUIRED_USE="pdf? ( tiff )"

COMMON_DEPEND="!!media-gfx/fbi
	media-libs/libexif
	virtual/jpeg:*
	virtual/ttf-fonts
	X? ( >=x11-libs/motif-2.3:0
		x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libXt )
	curl? ( net-misc/curl )
	fbcon? ( >=media-libs/fontconfig-2.2
		>=media-libs/freetype-2.0
		x11-libs/libdrm
		pdf? ( app-text/poppler[cairo]
			media-libs/libepoxy
			media-libs/mesa[gbm]
			x11-libs/cairo[opengl] )
	)
	gif? ( media-libs/giflib:= )
	lirc? ( app-misc/lirc )
	png? ( media-libs/libpng:* )
	scanner? ( media-gfx/sane-backends )
	tiff? ( media-libs/tiff:* )
	webp? ( media-libs/libwebp )"

DEPEND="${COMMON_DEPEND}
	X? ( x11-proto/xextproto
		x11-proto/xproto )"

RDEPEND=${COMMON_DEPEND}

src_prepare() {
	eapply \
		"${FILESDIR}"/ida-desktop.patch \
		"${FILESDIR}"/${PN}-2.10-giflib-4.2.patch \
		"${FILESDIR}"/${PN}-2.10-fprintf-format.patch

	use fbcon && ! use pdf && eapply "${FILESDIR}"/${PN}-2.12-drop-fbpdf.patch

	eapply_user

	tc-export CC CPP

	# upstream omission?
	echo ${PV} > VERSION
}

src_configure() {
	# Let autoconf do its job and then fix things to build fbida
	# according to our specifications
	emake Make.config

	gentoo_fbida() {
		local useflag=${1}
		local config=${2}

		local option="no"
		use ${useflag} && option="yes"

		sed -i \
			-e "s|HAVE_${config}.*|HAVE_${config} := ${option}|" \
			"${S}/Make.config" || die
	}

	gentoo_fbida X MOTIF
	gentoo_fbida curl LIBCURL
	gentoo_fbida fbcon LINUX_FB_H
	gentoo_fbida gif LIBUNGIF
	gentoo_fbida lirc LIBLIRC
	gentoo_fbida pdf LIBTIFF
	gentoo_fbida png LIBPNG
	gentoo_fbida scanner LIBSANE
	gentoo_fbida tiff LIBTIFF
	gentoo_fbida webp LIBWEBP
}

src_compile() {
	emake verbose=yes
}

src_install() {
	emake \
		DESTDIR="${D}" \
		STRIP="" \
		prefix=/usr \
		install

	dodoc README

	if use fbcon && ! use pdf; then
		rm "${D}"/usr/bin/fbgs "${D}"/usr/share/man/man1/fbgs.1 || die
	fi

	if use X ; then
		doicon "${WORKDIR}"/ida.png
		domenu desktop/ida.desktop
	fi
}
