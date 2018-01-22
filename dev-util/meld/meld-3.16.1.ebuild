# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

GCONF_DEBUG="no"

PYTHON_REQ_USE="xml"
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils gnome2 distutils-r1

DESCRIPTION="A graphical diff and merge tool"
HOMEPAGE="http://meldmerge.org/"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.36:2[dbus]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	>=dev-python/pygobject-3.8:3[cairo,${PYTHON_USEDEP}]
	gnome-base/gsettings-desktop-schemas
	>=x11-libs/gtk+-3.14:3[introspection]
	>=x11-libs/gtksourceview-3.14:3.0[introspection]
	x11-themes/hicolor-icon-theme"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/itstool
	sys-devel/gettext"
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

python_compile_all() {
	mydistutilsargs=( --no-update-icon-cache --no-compile-schemas )
}