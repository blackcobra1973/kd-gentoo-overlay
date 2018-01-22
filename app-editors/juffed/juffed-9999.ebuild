# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_REMOVE_MODULES="no"

inherit cmake-utils git-r3

DESCRIPTION="QScintilla-based tabbed text editor with syntax highlighting"
HOMEPAGE="http://juffed.com/
	https://github.com/Mezomish/juffed"
EGIT_REPO_URI="https://github.com/Mezomish/juffed.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug qt5"

DEPEND="app-i18n/enca
	!qt5? ( >=dev-qt/qtcore-4.2:4
		>=dev-qt/qtgui-4.2:4
		dev-qt/qtsingleapplication[X,qt4]
			>=x11-libs/qscintilla-2.1:0= )
	qt5? ( dev-qt/linguist-tools:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsingleapplication[X,qt5]
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
		>=x11-libs/qscintilla-2.9.4:0=[qt5] )"
RDEPEND=${DEPEND}

DOCS=( ChangeLog README )

src_prepare() {
	cmake-utils_src_prepare

	sed -i -e '/set(CMAKE_CXX_FLAGS/d' CMakeLists.txt || die

	if use qt5 ; then
		# Explicitly select Qt5
		eapply "${FILESDIR}/${P}-use-qt5.patch"

		# Fix a library name
		sed -i -e 's/QtSolutions_/Qt5Solutions_/g' \
			cmake/FindQtSingleApplication.cmake
	else
		# Explicitly select Qt4
		eapply "${FILESDIR}/${P}-use-qt4.patch"
	fi

	eapply_user
}

src_configure() {
	local mycmakeargs=( -DUSE_SYSTEM_QTSINGLEAPPLICATION=ON -DUSE_ENCA=ON
		-DUSE_QT5="$(usex qt5)"
		-DQT_LIBRARY_DIR="/usr/$(get_libdir)$(usex qt5 / /qt4)"
		-DQSCINTILLA_LIBRARY="/usr/$(get_libdir)/libqscintilla2_qt5.so" )

	cmake-utils_src_configure
}
