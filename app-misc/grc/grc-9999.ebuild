# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5,3_6} pypy )

inherit python-r1

DESCRIPTION="Generic Colouriser beautifies your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html
	https://github.com/garabik/grc"

if [ ${PV} = 9999 ]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/garabik/grc.git"
else
	SRC_URI="https://github.com/garabik/grc/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${PYTHON_DEPS}"

src_install() {
	python_foreach_impl python_doscript grc grcat

	insinto /usr/share/grc
	doins colourfiles/conf.* contrib/mrsmith/conf.*

	insinto /etc
	doins grc.conf

	dodoc CREDITS INSTALL README* Regexp.txt TODO debian/changelog
	docinto profiles
	dodoc grc.bashrc grc.fish grc.zsh
	doman grc.1 grcat.1
}

pkg_postinst() {
	elog "This ebuild doesn't install command aliases for safety"
	elog "If you want to alias, please refer to /usr/share/doc/${PF}/profiles/"
}