# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Notification daemon for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="dev-libs/atk:0
	>=dev-libs/dbus-glib-0.78:0
	>=dev-libs/glib-2.50.0:2
	gnome-base/gsettings-desktop-schemas:0
	>=media-libs/libcanberra-0.4:0[gtk3]
	>=sys-apps/dbus-0.78:0
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.22.0:2
	>=x11-libs/gtk+-3.22.0:3
	>=x11-libs/libnotify-0.7:0
	>=x11-libs/libwnck-3.0.0:3
	x11-libs/libX11:0
	virtual/libintl:0
	!x11-misc/notify-osd:*
	!x11-misc/qtnotifydaemon:*
	!x11-misc/notification-daemon:*"
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils:0
	>=dev-util/intltool-0.50.1:0
	sys-devel/gettext:0
	>=sys-devel/libtool-2.2.6:2
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure
}

src_install() {
	gnome2_src_install

	cat <<-EOF > "${T}/org.freedesktop.Notifications.service"
	[D-BUS Service]
	Name=org.freedesktop.Notifications
	Exec=/usr/libexec/mate-notification-daemon
	EOF

	insinto /usr/share/dbus-1/services
	doins "${T}/org.freedesktop.Notifications.service"
}
