# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_7 )

inherit gnome2 python-r1

DESCRIPTION="Tool to customize GNOME 3 options"
HOMEPAGE="https://wiki.gnome.org/action/show/Apps/GnomeTweakTool"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	dev-libs/glib:2[dbus]
	>=dev-python/pygobject-3.10.2:3[${PYTHON_USEDEP}]
	>=gnome-base/gsettings-desktop-schemas-3.21.2"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.0
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gnome-desktop-3.6.0.1:3=[introspection]
	>=gnome-base/gnome-settings-daemon-3
	net-libs/libsoup:2.4[introspection]
	>=x11-libs/gtk+-3.12:3[introspection]
	x11-libs/libnotify[introspection]"

src_prepare() {
	# Add contents of Gentoo's cursor theme directory to cursor theme list
	eapply "${FILESDIR}/${PN}-3.10.1-gentoo-cursor-themes.patch"

	gnome2_src_prepare
	python_copy_sources
}

src_configure() {
	python_foreach_impl run_in_build_dir gnome2_src_configure
}

src_compile() {
	python_foreach_impl run_in_build_dir gnome2_src_compile
}

src_test() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	install_python() {
		gnome2_src_install
		python_doscript gnome-tweak-tool || die
	}
	python_foreach_impl run_in_build_dir install_python
}