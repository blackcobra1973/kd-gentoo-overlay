# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# percol currently supports only Python 2.x
# https://github.com/mooz/percol#installation
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="percol adds flavor of interactive selection to pipe"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/mooz/percol
	https://pypi.python.org/pypi/percol"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
# Upstream supports Pinyin, but gentoo repo doesn't have it
# https://github.com/mooz/percol#pinyin-support
# IUSE="+migemo pinyin"
IUSE="+migemo"

COMMON_DEPEND=${PYTHON_DEPS}
DEPEND=${COMMON_DEPEND}
RDEPEND="${COMMON_DEPEND}
	>=dev-python/six-1.7.3[${PYTHON_USEDEP}]
	sys-libs/ncurses:*
	migemo? ( >=app-text/cmigemo-0.1.5[unicode] )"
#	pinyin? ( dev-python/pinyin-0.2.5 )

RESTRICT="mirror"
