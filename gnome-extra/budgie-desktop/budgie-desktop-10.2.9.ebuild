# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

VALA_MIN_API_VERSION="0.28"

inherit autotools gnome2-utils vala

DESCRIPTION="Flagship desktop of Solus, designed with the modern user in mind"
HOMEPAGE="https://solus-project.com/budgie/
	https://github.com/budgie-desktop/budgie-desktop"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.xz"
IUSE="bluetooth control-center +introspection"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
COMMON_DEPEND=">=app-i18n/ibus-1.5.10[vala]
	>=dev-libs/glib-2.44.0:2
	dev-libs/gjs
	>=dev-libs/libpeas-1.8.0:0
	>=gnome-base/gnome-desktop-3.18.0:3
	>=gnome-base/gnome-menus-3.10.1
	>=media-sound/pulseaudio-2.0
	>=sys-apps/accountsservice-0.6
	>=sys-auth/polkit-0.110
	>=sys-power/upower-0.9.20
	>=x11-libs/gtk+-3.16.0:3
	>=x11-libs/libwnck-3.14.0:3
	>=x11-wm/mutter-3.18.0
	bluetooth? ( >=net-wireless/gnome-bluetooth-3.16.0 )"
DEPEND="${COMMON_DEPEND}
	$(vala_depend)
	>=dev-util/intltool-0.50.0
	introspection? ( >=dev-libs/gobject-introspection-1.44.0 )"
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gnome-session-3.18.0
	x11-themes/gnome-themes-standard
	control-center? ( >=gnome-base/gnome-control-center-3.20:2 )"

RESTRICT="mirror"

src_prepare() {
	eapply_user
	vala_src_prepare
	eautoreconf
}

src_configure() {
	econf --disable-stateless \
		$(use_enable introspection)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}