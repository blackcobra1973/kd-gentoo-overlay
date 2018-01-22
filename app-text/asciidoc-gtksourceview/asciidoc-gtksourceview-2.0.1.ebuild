# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

MY_PN="asciidoc-gtk-highlight"
MY_PV=$(get_after_major_version)

DESCRIPTION="AsciiDoc bindings for gtksourceview"
HOMEPAGE="https://launchpad.net/asciidoc-gtk-highlight"
SRC_URI="https://launchpad.net/${MY_PN}/trunk/${MY_PV}/+download/${MY_PN}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS=""

DEPEND="x11-libs/gtksourceview:${SLOT}"
RDEPEND="${DEPEND}
	x11-libs/gtksourceview:${SLOT}"

S="${WORKDIR}"
RESTRICT="binchecks mirror strip"

src_install() {
	insinto /usr/share/gtksourceview-${SLOT}/language-specs
	doins asciidoc.lang
	insinto /usr/share/doc/${PF}
	doins README.pdf
	dodoc README README.pdf
}
