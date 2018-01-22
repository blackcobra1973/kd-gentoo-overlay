# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_7 )

inherit autotools git-r3 gnome2 python-single-r1

DESCRIPTION="Python bindings for Caja file manager"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

COMMON_DEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	>=dev-python/pygobject-3.0.0:3[${PYTHON_USEDEP}]
	>=mate-base/caja-1.17.1:0[introspection]
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0:0
	virtual/pkgconfig:0
	doc? ( dev-libs/libxslt:0
		>=dev-util/gtk-doc-1.9:0 )"
RDEPEND="${COMMON_DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README"

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
		$(use_enable doc gtk-doc)
}

src_install() {
	gnome2_src_install

	# Keep the directory for systemwide extensions.
	keepdir /usr/share/python-caja/extensions/
}
