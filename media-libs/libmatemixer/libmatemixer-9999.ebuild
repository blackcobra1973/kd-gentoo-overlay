# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Mixer library for MATE Desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="alsa debug oss pulseaudio"

COMMON_DEPEND=">=dev-libs/glib-2.50.0:2
	>=dev-libs/gobject-introspection-1.38.0:0
	alsa? ( >=media-libs/alsa-lib-1.0.5:0 )
	oss? ( virtual/os-headers:0 )
	pulseaudio? ( >=media-sound/pulseaudio-2.0.0:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-1.10:0
	>=dev-util/intltool-0.35.0:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

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
		--enable-null \
		$(use_enable alsa) \
		$(use_enable oss) \
		$(use_enable pulseaudio)
}