# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1 gnome2-utils python-r1 python-utils-r1 versionator

MPV=$(get_version_component_range 1-2)

DESCRIPTION="LightDM Gtk+ Greeter settings editor"
HOMEPAGE="https://launchpad.net/lightdm-gtk-greeter-settings"
SRC_URI="https://launchpad.net/${PN}/${MPV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="nls"

COMMON_DEPEND="${PYTHON_DEPS}"
DEPEND="${COMMON_DEPEND}
	>=dev-python/python-distutils-extra-2.18[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	dev-libs/glib:2
	sys-auth/polkit
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
	>=x11-misc/lightdm-gtk-greeter-2.0.0"

RESTRICT="mirror"

DOCS=( NEWS README )

pkg_setup() {
	python_setup
}

src_prepare() {
	default
	python_fix_shebang "${S}"
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