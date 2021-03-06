# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Python 2 is needed by /usr/bin/cinnamon-desktop-migrate-mediakeys
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils gnome2 python-single-r1

DESCRIPTION="A collection of libraries and utilites used by Cinnamon"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-desktop/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2+"
SLOT="0/4" # subslot = libcinnamon-desktop soname version
KEYWORDS=""
IUSE="+introspection +pulseaudio systemd"

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.37.3:2[dbus]
	>=gnome-base/gsettings-desktop-schemas-3.5.91
	>=x11-libs/gdk-pixbuf-2.22:2[introspection?]
	>=x11-libs/gtk+-3.3.16:3[introspection?]
	x11-libs/cairo:=[X]
	x11-libs/libX11
	>=x11-libs/libXext-1.1
	>=x11-libs/libXrandr-1.3
	x11-libs/libxkbfile
	x11-misc/xkeyboard-config
	introspection? ( >=dev-libs/gobject-introspection-0.9.7:= )
	pulseaudio? ( media-sound/pulseaudio[glib] )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.4
	>=dev-util/intltool-0.40.6
	gnome-base/gnome-common
	|| ( x11-base/xorg-proto
		( x11-proto/randrproto
			x11-proto/xproto ) )
	virtual/pkgconfig"
# PyGObject might be depended by libcvc
RDEPEND="${COMMON_DEPEND}
	pulseaudio? ( dev-python/pygobject:3[${PYTHON_USEDEP}] )"

pkg_setup() {
	python_setup
}

src_prepare() {
	if ! use pulseaudio; then
		sed -i -e 's/libcvc//g' "${S}/Makefile.am"
		sed -i -e 's/PKG_CHECK_MODULES(CVC.*//' "${S}/configure.ac"
		sed -i -e 's_libcvc/.*__g' "${S}/configure.ac"
	fi
	eautoreconf
	python_fix_shebang files/usr/bin/cinnamon-desktop-migrate-mediakeys
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		$(use_enable introspection)
}

src_install() {
	gnome2_src_install

	# set sane default gschema values for systemd users
	if use systemd; then
		insinto /usr/share/glib-2.0/schemas/
		newins "${FILESDIR}"/${PN}-2.6.4.systemd.gschema.override ${PN}.systemd.gschema.override
	fi
}
