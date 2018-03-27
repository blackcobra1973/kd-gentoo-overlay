# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_7 )

inherit autotools git-r3 gnome2 python-single-r1

DESCRIPTION="Applets for use with MATE panel"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

# Codes: GPLv2+, Docs: FDLv1.1, some Icons: LGPLv2.1
LICENSE="GPL-2+ FDL-1.1 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="X +cpufreq gucharmap ipv6 nls policykit upower weather wifi"

# gnome-extra/gucharmap:2 isn't in the gentoo repository
REQUIRED_USE="policykit? ( cpufreq )"

COMMON_DEPEND="${PYTHON_DEPS}
	app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/dbus-glib-0.74:0
	>=dev-libs/glib-2.50:2
	>=dev-libs/libxml2-2.5.0:2
	dev-python/pygobject:3
	>=gnome-base/libgtop-2.12.0:2=
	>=mate-base/mate-panel-1.17.0:0
	!!net-analyzer/mate-netspeed
	>=sys-apps/dbus-1.1.2:0
	x11-libs/gdk-pixbuf:2
	x11-libs/libX11:0
	>=x11-libs/gtk+-3.22.0:3
	>=x11-libs/libnotify-0.7.0:0
	>=x11-libs/libwnck-3.4.0:3
	>=x11-libs/libxklavier-4:0
	x11-libs/pango:0
	virtual/libintl:0
	cpufreq? ( sys-power/cpupower:0 )
	gucharmap? ( >=gnome-extra/gucharmap-3.0.0:2.90 )
	policykit? ( >=sys-auth/polkit-0.97:0 )
	upower? ( || ( >=sys-power/upower-0.9.4:0
		>=sys-power/upower-pm-utils-0.9.4:0 ) )
	weather? ( >=dev-libs/libmateweather-1.19.1:0 )
	wifi? ( net-wireless/wireless-tools )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.3
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	>=dev-util/intltool-0.50.1:0
	dev-libs/libxslt:0
	~mate-base/mate-common-9999:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	# Temporary revert to fix the system-monitor applet
	eapply -p1 "${FILESDIR}/${P}-revert-graph-scales.patch"

	default
	eautoreconf
}

src_configure() {
# libapm needed for battstat
	gnome2_src_configure \
		--libexecdir=/usr/libexec/mate-applets \
		$(use_with X x) \
		--disable-battstat \
		$(usex cpufreq '' '--disable-cpufreq') \
		$(use_enable cpufreq frequency-selector) \
		$(use_with cpufreq cpufreq-lib cpupower) \
		$(use_with upower) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable policykit polkit) \
		$(use policykit || use_enable cpufreq suid) \
		--enable-stickynotes
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check
}

src_install() {
	gnome2_src_install

	# Omit battstat
	local APPLETS="accessx-status charpick command drivemount geyes
			multiload netspeed stickynotes timerapplet trashapplet"
	use cpufreq && APPLETS="${APPLETS} cpufreq"
	use weather && APPLETS="${APPLETS} mateweather"

	for applet in ${APPLETS}; do
		docinto ${applet}

		for d in AUTHORS ChangeLog NEWS README README.themes TODO; do
			[ -s ${applet}/${d} ] && dodoc ${applet}/${d}
		done
	done
}
