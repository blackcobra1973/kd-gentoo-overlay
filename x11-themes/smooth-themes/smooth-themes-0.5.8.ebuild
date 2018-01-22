# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools

DESCRIPTION="Themes for Smooth GTK1/GTK2 Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=x11-libs/gdk-pixbuf-2.0.0:2
	>=x11-libs/gtk+-2.0.0:2
	>=x11-themes/gtk-engines-2.15.3:2
	x11-themes/murrine-themes:0"
DEPEND="${COMMON_DEPEND}
	>=x11-misc/icon-naming-utils-0.8.7:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="binchecks mirror strip"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	eautoreconf
}