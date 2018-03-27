# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Though Nikola supports Python 3.6 ( See Upstream: 774a626 ),
# some dependended pakages still don't have [python_targets_python3_6]
# Should wait for their update
# dev-python/ghp-import2	dev-python/husl		dev-python/phpserialize
# PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
PYTHON_COMPAT=( python{2_7,3_4,3_5} )
PYTHON_REQ_USE="gdbm"

inherit distutils-r1 python-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="https://getnikola.com/
	https://pypi.python.org/pypi/Nikola"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/getnikola/${PN}.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/getnikola/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# CC0-1.0: nikola/data/samplesite/pages/dr-nikolas-vendetta.rst
LICENSE="CC0-1.0 MIT"
SLOT="0"
IUSE="+assets bbcode charts ghpages husl hyphenation ipython jinja micawber
	php typogrify watchdog websocket yaml"

COMMON_DEPEND=">=dev-python/docutils-0.12[${PYTHON_USEDEP}]
	>=dev-python/setuptools-20.3[${PYTHON_USEDEP}]"
DEPEND=${COMMON_DEPEND}
RDEPEND="${COMMON_DEPEND}
	>=dev-python/blinker-1.3[${PYTHON_USEDEP}]
	>=dev-python/doit-0.29.0[${PYTHON_USEDEP}]
	>=dev-python/logbook-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.3.5[${PYTHON_USEDEP}]
	>=dev-python/mako-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/markdown-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/natsort-3.5.2[${PYTHON_USEDEP}]
	>=dev-python/piexif-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/pillow-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-1.6[${PYTHON_USEDEP}]
	>=dev-python/PyRSS2Gen-1.1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/unidecode-0.04.16[${PYTHON_USEDEP}]
	>=dev-python/yapsy-1.11.223[${PYTHON_USEDEP}]
	assets? ( >=dev-python/webassets-0.10.1[${PYTHON_USEDEP}] )
	bbcode? ( dev-python/bbcode[${PYTHON_USEDEP}] )
	charts? ( >=dev-python/pygal-2.0.0[${PYTHON_USEDEP}] )
	ghpages? ( || ( >=dev-python/ghp-import-0.4.1-r1[${PYTHON_USEDEP}]
		>=dev-python/ghp-import2-1.0.0[${PYTHON_USEDEP}] ) )
	husl? ( >=dev-python/husl-4.0.2[${PYTHON_USEDEP}] )
	hyphenation? ( >=dev-python/pyphen-0.9.1[${PYTHON_USEDEP}] )
	ipython? ( >=dev-python/ipykernel-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/notebook-4.0.0[${PYTHON_USEDEP}] )
	jinja? ( >=dev-python/jinja-2.7.2[${PYTHON_USEDEP}] )
	micawber? ( >=dev-python/micawber-0.3.0[${PYTHON_USEDEP}] )
	php? ( >=dev-python/phpserialize-1.3[${PYTHON_USEDEP}] )
	typogrify? ( >=dev-python/typogrify-2.0.4[${PYTHON_USEDEP}] )
	watchdog? ( ~dev-python/watchdog-0.8.3[${PYTHON_USEDEP}] )
	websocket? ( ~dev-python/ws4py-0.4.2[${PYTHON_USEDEP}] )
	yaml? ( =dev-python/pyyaml-3.12[${PYTHON_USEDEP}] )"

# mock, coverage, pytest, pytest-cov, freezegun, codacy-coverage and colorama
# are necessary for test.
# https://github.com/getnikola/nikola/blob/v7.8.9/requirements-tests.txt
RESTRICT="mirror test"

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}/usr/share/doc/${PN}"

	dodoc AUTHORS.txt CHANGES.txt CONTRIBUTING.rst README.rst docs/*.txt
	doman docs/man/nikola.1.gz
}