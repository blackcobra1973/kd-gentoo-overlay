# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="MATE session manager"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS=""
IUSE="debug elibc_FreeBSD gnome-keyring ipv6 systemd"

# x11-misc/xdg-user-dirs{,-gtk} are needed to create the various XDG_*_DIRs, and
# create .config/user-dirs.dirs which is read by glib to get G_USER_DIRECTORY_*
# xdg-user-dirs-update is run during login (see 10-user-dirs-update-gnome below).

COMMON_DEPEND=">=dev-libs/dbus-glib-0.76:0
	>=dev-libs/glib-2.50.0:2
	dev-libs/libxslt:0
	sys-apps/dbus:0
	>=sys-auth/consolekit-1.0
	x11-apps/xdpyinfo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.22.0:3
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	x11-libs/libXau:0
	x11-libs/libXext:0
	x11-libs/libXrender:0
	x11-libs/libXtst:0
	x11-libs/pango:0
	x11-libs/xtrans:0
	x11-misc/xdg-user-dirs:0
	x11-misc/xdg-user-dirs-gtk:0
	virtual/libintl:0
	elibc_FreeBSD? ( dev-libs/libexecinfo:0 )
	gnome-keyring? ( gnome-base/gnome-keyring:0 )
	systemd? ( sys-apps/systemd:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40:0
	>=dev-lang/perl-5:0
	mate-base/mate-common:0
	>=sys-devel/gettext-0.10.40:0
	virtual/pkgconfig:0
	!<gnome-base/gdm-2.20.4:*"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

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
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--with-default-wm=mate-wm \
		$(use_enable ipv6) \
		$(use_with systemd)
}

src_install() {
	gnome2_src_install

	dodir /etc/X11/Sessions/
	exeinto /etc/X11/Sessions/
	doexe "${FILESDIR}"/MATE

	dodir /usr/share/mate/applications/
	insinto /usr/share/mate/applications/
	doins "${FILESDIR}"/defaults.list

	dodir /etc/X11/xinit/xinitrc.d/
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}"/15-xdg-data-mate

	# This should be done in MATE too, see Gentoo bug #270852
	doexe "${FILESDIR}"/10-user-dirs-update-mate
}
