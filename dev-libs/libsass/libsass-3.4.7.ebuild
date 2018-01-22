# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils ltprune multilib-minimal

DESCRIPTION="C/C++ implementation of Sass CSS compiler"
HOMEPAGE="http://libsass.org/"
SRC_URI="https://github.com/sass/libsass/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/0"
KEYWORDS="~x86 ~amd64 ~amd64-linux"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( Readme.md SECURITY.md )

src_prepare() {
	default
	eautoreconf
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-shared
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	prune_libtool_files
}

multilib_src_install_all() {
	einstalldocs
	dodoc -r "${S}/docs"
}
