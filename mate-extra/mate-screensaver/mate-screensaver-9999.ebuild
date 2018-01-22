# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2 readme.gentoo-r1

DESCRIPTION="Screensaver and locker for MATE Desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X consolekit debug kernel_linux libnotify opengl pam systemd"

DOC_CONTENTS="
	Information for converting screensavers is located in
	/usr/share/doc/${PF}/xss-conversion.txt*
"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.71:0
	>=dev-libs/glib-2.36.0:2
	gnome-base/dconf:0
	>=mate-base/libmatekbd-1.17.0:0
	>=mate-base/mate-desktop-1.17.0:0
	>=mate-base/mate-menus-1.10:0
	>=sys-apps/dbus-0.30:0
	>=x11-libs/gdk-pixbuf-2.14:2
	>=x11-libs/libX11-1.0:0
	x11-libs/cairo:0
	>=x11-libs/gtk+-3.14.0:3
	x11-libs/libXext:0
	x11-libs/libXrandr:0
	x11-libs/libXScrnSaver:0
	x11-libs/libXxf86misc:0
	x11-libs/libXxf86vm:0
	x11-libs/libxklavier:0
	x11-libs/pango:0
	virtual/libintl:0
	consolekit? ( sys-auth/consolekit:0 )
	libnotify? ( >=x11-libs/libnotify-0.7:0 )
	opengl? ( virtual/opengl:0 )
	pam? ( gnome-base/gnome-keyring:0 virtual/pam:0 )
	!pam? ( kernel_linux? ( sys-apps/shadow:0 ) )
	systemd? ( sys-apps/systemd:0= )
	!!<gnome-extra/gnome-screensaver-3:*"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50.1:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	x11-proto/randrproto:0
	x11-proto/scrnsaverproto:0
	x11-proto/xextproto:0
	x11-proto/xf86miscproto:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-locking \
		--with-kbd-layout-indicator \
		--with-xf86gamma-ext \
		--with-xscreensaverdir=/usr/share/xscreensaver/config \
		--with-xscreensaverhackdir=/usr/$(get_libdir)/misc/xscreensaver \
		$(use_with X x) \
		$(use_with consolekit console-kit) \
		$(use_enable debug) \
		$(use_with libnotify) \
		$(use_with opengl libgl) \
		$(use_enable pam) \
		$(use_with systemd)
}

src_install() {
	gnome2_src_install

	# Install the conversion script in the documentation.
	dodoc "${S}"/data/migrate-xscreensaver-config.sh
	dodoc "${S}"/data/xscreensaver-config.xsl
	dodoc "${FILESDIR}"/xss-conversion.txt

	# Non PAM users will need this suid to read the password hashes.
	# OpenPAM users will probably need this too when
	# http://bugzilla.gnome.org/show_bug.cgi?id=370847
	# is fixed.
	if ! use pam ; then
		fperms u+s /usr/libexec/mate-screensaver-dialog
	fi

	readme.gentoo_create_doc
}

pkg_postinst() {
	gnome2_pkg_postinst
	readme.gentoo_print_elog
}
