# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="ast be bg ca cmn cs da de el en_GB eo es_AR es_MX es et eu fa_IR fi
	fr gl he hu id_ID it ja ko ky lt lv ml_IN ms nl pl pt_BR pt_PT ro ru si sk
	sq sr@latin sr sr_RS sv ta tr uk vi zh_CN zh_TW"
PLOCALE_BACKUP="en_GB"

inherit autotools git-r3 gnome2-utils l10n xdg-utils

DESCRIPTION="A lightweight and versatile audio player"
HOMEPAGE="http://audacious-media-player.org/"
EGIT_REPO_URI="https://github.com/audacious-media-player/${PN}.git"
SRC_URI="mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

# bandeled libguess is BSD (3-clause)
LICENSE="BSD-2 BSD"
SLOT="0"
KEYWORDS=""
IUSE="+gtk -gtk3 qt5"
REQUIRED_USE="|| ( gtk qt5 )
	gtk3? ( gtk )"

COMMON_DEPEND=">=dev-libs/glib-2.28
	dev-libs/libxml2
	>=sys-apps/dbus-0.6.0
	>=sys-devel/gcc-4.7.0:*
	>=x11-libs/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	gtk? ( !gtk3? ( x11-libs/gtk+:2 ) )
	gtk3? ( x11-libs/gtk+:3 )
	qt5? ( dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5
		dev-qt/qtwidgets:5 )"
DEPEND="${COMMON_DEPEND}
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}
PDEPEND="~media-plugins/audacious-plugins-9999[gtk=,gtk3=,qt5=]"

pkg_setup() {
	if use gtk3 ; then
		export S="${WORKDIR}/${P}-gtk3"
		export EGIT_BRANCH="master-gtk3"
	fi
}

src_unpack() {
	git-r3_src_unpack
	default
}

src_prepare() {
	eautoreconf
	l10n_for_each_disabled_locale_do remove_locales
	eapply_user
}

src_configure() {
	econf --enable-dbus \
		$(use_enable gtk) \
		$(use_enable qt5 qt)
}

src_install() {
	default
	dodoc AUTHORS

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}

pkg_postinst() {
	xdg_desktop_database_update

	use gtk && gnome2_icon_cache_update

	if use qt5 && use gtk ; then
		ewarn 'It is not possible to switch between GTK+ and Qt while Audacious is running.'
		ewarn 'Run audacious --qt to get the Qt interface.'
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

remove_locales() {
	sed -i "s/${1}.po//" po/Makefile
}