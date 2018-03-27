# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils gnome2

DESCRIPTION="Cinnamon session manager"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-session/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="doc ipv6 -old-upower systemd"
REQUIRED_USE="?? ( old-upower systemd )"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.88
	>=dev-libs/glib-2.37.3:2
	media-libs/libcanberra
	sys-auth/polkit
	virtual/opengl
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3:3
	x11-libs/cairo
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango[X]
	old-upower? ( >=sys-power/upower-pm-utils-0.9.23 )
	systemd? ( >=sys-apps/systemd-183 )
	!systemd? ( sys-power/upower )"
# gnome-base/gnome-common is needed for eautoreconf
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.40.6
	gnome-base/gnome-common
	virtual/pkgconfig
	doc? ( app-text/xmlto )"
RDEPEND="${COMMON_DEPEND}
	>=gnome-extra/cinnamon-desktop-3.0[systemd=]
	!systemd? ( || ( sys-auth/consolekit
		sys-auth/elogind[policykit] ) )"

src_prepare() {
	# make upower and logind check non-automagic
	eapply "${FILESDIR}/${PN}-3.0.1-automagic.patch"
	eapply "${FILESDIR}/${PN}-3.6.1-elogind.patch"
	eapply "${FILESDIR}/${PN}-3.6.1-elogind2.patch"
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-gconf \
		--disable-static \
		$(use_enable doc docbook-docs) \
		$(use_enable ipv6) \
		$(use_enable old-upower) \
		$(use_enable systemd logind)
}