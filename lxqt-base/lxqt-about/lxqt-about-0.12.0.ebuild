# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils

DESCRIPTION="LXQt about dialog"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="https://github.com/lxde/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5=
	dev-qt/qtdbus:5=
	dev-qt/qtgui:5=
	dev-qt/qtwidgets:5=
	dev-qt/qtx11extras:5=
	dev-qt/qtxml:5=
	~lxqt-base/liblxqt-${PV}
	!!lxqt-base/lxqt-common
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=( -DPULL_TRANSLATIONS=OFF )
	cmake-utils_src_configure
}
