# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Python fork of SmartyPants, a free web publishing plug-in"
SRC_URI="https://github.com/leohemsted/smartypants.py/archive/v${PV}.tar.gz
	-> ${P}.tar.gz"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.whl"
HOMEPAGE="https://github.com/leohemsted/smartypants.py
	https://pypi.python.org/pypi/smartypants/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=${PYTHON_DEPS}
RDEPEND=${PYTHON_DEPS}

S="${WORKDIR}/${P/-/.py-}"
RESTRICT="mirror"

DOCS="CHANGES.rst README.rst"