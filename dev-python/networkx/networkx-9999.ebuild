# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1 virtualx

DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="http://networkx.github.io/ https://github.com/networkx/networkx"

LICENSE="BSD"
SLOT="0"
IUSE="doc examples matplotlib scipy test"

#FIXME: Add USE flags here and version requirements below for all optional
#dependencies supported by NetworkX. According to the "extras_require" key
#of the top-level "setup.py" file, these include:
#    'numpy', 'pandas', 'pydot', 'gdal', 'lxml'
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	doc? ( || ( $(python_gen_useflags -2) ) )
"

DEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
		$(python_gen_cond_dep 'dev-python/numpydoc[${PYTHON_USEDEP}]' python2_7)
		$(python_gen_cond_dep 'dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]' python2_7 python{3_3,3_4})
	)
	test? (
		${COMMON_DEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/pydot[${PYTHON_USEDEP}]' -2)
	)
"
RDEPEND="${PYTHON_DEPS}
	>=dev-python/decorator-4.1.0[${PYTHON_USEDEP}]
	examples? (
		${COMMON_DEPEND}
		dev-python/pygraphviz[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
	matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
	scipy? ( sci-libs/scipy[${PYTHON_USEDEP}] )
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/networkx/networkx"
	EGIT_BRANCH="master"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"
	KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
fi

python_prepare_all() {
	# Avoid d'loading of file objects.inv from 2 sites of python docs
	sed -e "s/'sphinx.ext.intersphinx', //" -i doc/conf.py || die '"sed" failed.'
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		python_setup -2
		emake -C doc html
	fi
}

python_test() {
	virtx nosetests -vv || die '"nosetests" failed.'
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
