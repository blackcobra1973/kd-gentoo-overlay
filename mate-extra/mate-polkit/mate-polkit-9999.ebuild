# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2

DESCRIPTION="Authentication agent of PolicyKit for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="appindicator doc +introspection"

COMMON_DEPEND=">=dev-libs/glib-2.50.0:2
	>=sys-auth/polkit-0.102:0[introspection?]
	x11-libs/gdk-pixbuf:2[introspection?]
	>=x11-libs/gtk+-3.22.0:3[introspection?]
	virtual/libintl:0
	appindicator? ( dev-libs/libappindicator:3 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.2:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35.0:0
	~mate-base/mate-common-9999:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	!<gnome-extra/polkit-gnome-0.102:*
	doc? ( >=dev-util/gtk-doc-1.3:0 )"
RDEPEND="${COMMON_DEPEND}"
# Entropy PMS specific. This way we can install the pkg into the build chroots.
ENTROPY_RDEPEND="!lxde-base/lxpolkit:*"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

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
		--disable-static \
		$(use_enable appindicator) \
		$(use_enable introspection)
}