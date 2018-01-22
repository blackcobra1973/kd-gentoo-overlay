# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 gnome2-utils

DESCRIPTION="Qt-based program for fast creating screenshots"
HOMEPAGE="https://github.com/DOOMer/screengrab"
EGIT_REPO_URI="https://github.com/DOOMer/screengrab.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus +xdg"

COMMON_DEPEND="dev-libs/libqtxdg
	>=dev-qt/linguist-tools-5.2:5
	>=dev-qt/qtcore-5.2:5
	>=dev-qt/qtdbus-5.2:5
	>=dev-qt/qtgui-5.2:5
	>=dev-qt/qtnetwork-5.2:5
	>=dev-qt/qtwidgets-5.2:5
	>=dev-qt/qtx11extras-5.2:5
	kde-frameworks/kwindowsystem:5
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxcb"
DEPEND="${COMMON_DEPEND}
	>=dev-util/cmake-2.8.11
	>sys-devel/gcc-4.5"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS CHANGELOG README.md  )
HTML_DOCS=( docs/html )

src_prepare() {
	# QTXDG_USE_FILE is obsolete, Qt5Xdg should be linked dynamically
	# https://github.com/lxde/libqtxdg/commit/d1ba4bc
	if has_version '>=dev-libs/libqtxdg-1.3.0' ; then
		sed -e '/include(\${QTXDG_USE_FILE})/d' \
			-e 's/\(target_link_libraries(screengrab extedit)\)/\1\ntarget_link_libraries(screengrab Qt5Xdg)/' \
			-i CMakeLists.txt || die
	fi

	cmake-utils_src_prepare
	eapply_user
}

src_configure() {
	#  Though "-DSG_USE_SYSTEM_QXT" remains in upstream, it's broken
	# because x11-libs/libqxt doesn't support modern Qt libraries.
	# LIBQXT IS NO LONGER MAINTAINED ( https://bitbucket.org/libqxt/libqxt ).
	#  "-DSG_GLOBALSHORTCUTS" doesn't work without "-DSG_USE_SYSTEM_QXT".
	local mycmakeargs=( -DSG_DOCDIR=${PF}
		-DSG_USE_SYSTEM_QXT=OFF -DSG_GLOBALSHORTCUTS=OFF )

	if use dbus	; then
		mycmakeargs=( ${mycmakeargs[@]} -DSG_DBUS_NOTIFY=ON )
	else
		mycmakeargs=( ${mycmakeargs[@]} -DSG_DBUS_NOTIFY=OFF )
	fi

	if use xdg ; then
		mycmakeargs=( ${mycmakeargs[@]} -DSG_XDG_CONFIG_SUPPORT=ON )
	else
		mycmakeargs=( ${mycmakeargs[@]} -DSG_XDG_CONFIG_SUPPORT=OFF )
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	einstalldocs
	insinto /usr/share/icons/hicolor/32x32/apps
	doins img/screengrab.png
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
