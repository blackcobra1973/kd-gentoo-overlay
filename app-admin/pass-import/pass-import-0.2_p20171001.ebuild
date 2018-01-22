# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_COMMIT="0f5eb109f9dcd739da5310f58c2b73aee5a61a33"

inherit git-r3 python-utils-r1

DESCRIPTION="generic importer extension for password manager ZX2C4's pass"
HOMEPAGE="https://github.com/roddhjav/pass-import"
EGIT_REPO_URI="https://github.com/roddhjav/pass-import"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="app-shells/bash"
DEPEND=${COMMON_DEPEND}
RDEPEND="${COMMON_DEPEND}
	>=app-admin/pass-1.7"

RESTRICT="mirror"

src_prepare() {
	eapply_user

	local EPYTHON="python2"
	for fn in kedpm keepass keepassx kwallet password-exporter revelation
	do python_fix_shebang importers/${fn}2pass.py
	done

	local EPYTHON="python3"
	for fn in chrome keepass2csv
	do python_fix_shebang importers/${fn}2pass.py
	done
}

src_compile() {
	:
}

pkg_postinst() {
	elog "'PASSWORD_STORE_ENABLE_EXTENSIONS=true' is needed to run 'pass import'."
	elog "Interpreters are additionally needed to run some importers"
	elog " - Ruby is needed for:"
	elog "     1password, gorrilla, lastpass, roboform"
	elog " - Python2 is needed for:"
	elog "     kedpm, keepass, keepassx, kwallet, password-exporter, revelation"
	elog " - Python3 is needed for:"
	elog "     chrome, keepass2csv"
	elog " - Perl is needed for:"
	elog "     fpm"
}