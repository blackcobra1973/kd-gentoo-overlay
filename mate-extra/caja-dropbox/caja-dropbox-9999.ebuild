# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_7 )

inherit autotools git-r3 gnome2 python-single-r1 linux-info user

DESCRIPTION="Dropbox extension for Caja file manager"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"

COMMON_DEPEND="dev-libs/atk:0
	>=dev-libs/glib-2.50.0:2
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	>=mate-base/caja-1.17.1:0
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libXinerama:0
	x11-libs/pango:0"
DEPEND="${COMMON_DEPEND}
	dev-python/docutils:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}
		net-misc/dropbox:0"
CONFIG_CHECK="~INOTIFY_USER"

DOCS=( AUTHORS ChangeLog NEWS README )

pkg_setup () {
	python-single-r1_pkg_setup
	check_extra_config
	enewgroup dropbox
}

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare

	# Use system dropbox.
	sed -e "s|~/[.]dropbox-dist|/opt/dropbox|" \
		-e 's|\(DROPBOXD_PATH = \).*|\1"/opt/dropbox/dropboxd"|' \
			-i caja-dropbox.in || die

	# Use system rst2man.
	eapply "${FILESDIR}"/${P}-system-rst2man.patch

	AT_NOELIBTOOLIZE=yes eautoreconf
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		$(use_enable debug)
}

src_install() {
	python_fix_shebang caja-dropbox.in

	gnome2_src_install

	local extensiondir="$(pkg-config --variable=extensiondir libcaja-extension)"
	[ -z ${extensiondir} ] && die "pkg-config unable to get caja extensions dir"

	# Strip $EPREFIX from $extensiondir as fowners/fperms act on $ED not $D.
	extensiondir="${extensiondir#${EPREFIX}}"
	use prefix || fowners root:dropbox "${extensiondir}"/libcaja-dropbox.so
	fperms o-rwx "${extensiondir}"/libcaja-dropbox.so
}

pkg_postinst () {
	gnome2_pkg_postinst

	elog
	elog "Add any users who wish to have access to the dropbox caja"
	elog "plugin to the group 'dropbox'. You need to setup a drobox account"
	elog "before using this plugin. Visit ${HOMEPAGE} for more information."
	elog
}
