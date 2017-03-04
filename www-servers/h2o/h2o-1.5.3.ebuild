# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils systemd user

DESCRIPTION="An optimized HTTP server with support for HTTP/1.x and HTTP/2"
HOMEPAGE="https://github.com/h2o/h2o"
SRC_URI="https://github.com/h2o/h2o/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="libressl mruby websocket"

DEPEND="
	dev-libs/libyaml
	>=dev-libs/libuv-1.0.0
	libressl? ( dev-libs/libressl )
        mruby? (
                sys-devel/bison
                dev-lang/ruby
        )
	websocket? ( net-libs/wslay )"

RDEPEND="${DEPEND}"

pkg_setup(){
	enewgroup h2o
	enewuser h2o -1 -1 /var/www/localhost/htdocs h2o
}

src_prepare(){
	cmake-utils_src_prepare
}

src_configure(){
	local mycmakeargs=(
		$(cmake-utils_use_with !libressl BUNDLED_SSL)
		$(cmake-utils_use_with mruby MRUBY)
	)
	cmake-utils_src_configure
}

src_compile(){
	cmake-utils_src_compile
}

src_install(){
	cmake-utils_src_install

	newinitd "${FILESDIR}"/h2o.initd h2o
	systemd_dounit "${FILESDIR}"/h2o.service

	insinto /etc/h2o
	doins "${FILESDIR}"/h2o.conf

	keepdir /var/l{ib,og}/h2o /var/www/localhost/htdocs
	fowners h2o:h2o /var/l{ib,og}/h2o
	fperms 0750 /var/l{ib,og}/h2o
}

