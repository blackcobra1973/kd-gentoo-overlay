# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/gokyle/${PN}"

inherit golang-build golang-vcs

DESCRIPTION="Two-factor authentication in Go"
HOMEPAGE="https://github.com/gokyle/twofactor"

LICENSE="MIT"
SLOT="0"

COMMON_DEPEND="dev-go/qr"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}