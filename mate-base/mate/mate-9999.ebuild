# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Meta ebuild for MATE, a traditional desktop environment"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS=""
IUSE="+base -bluetooth +extras netbook +themes user-guide"

RDEPEND="~mate-base/mate-desktop-9999:0
	~mate-base/mate-menus-9999:0
	~mate-base/mate-panel-9999:0
	~mate-base/mate-session-manager-9999:0
	~mate-base/mate-settings-daemon-9999:0
	|| ( ~x11-misc/mate-notification-daemon-9999:0
		virtual/notification-daemon:0 )
	~x11-wm/marco-9999:0
	base? ( ~mate-base/caja-9999:0
		~mate-base/mate-applets-meta-9999:0[gtk3(+)]
		~mate-base/mate-control-center-9999:0[gtk3(+)]
		~mate-extra/mate-media-9999:0
		~x11-misc/mozo-9999
		~x11-terms/mate-terminal-9999:0 )
	bluetooth? ( net-wireless/blueman:0 )
	extras? ( ~app-arch/engrampa-9999:0
		~app-editors/pluma-9999:0
		~app-text/atril-9999:0[gtk3(+)]
		~mate-extra/mate-power-manager-9999:0
		~mate-extra/mate-screensaver-9999:0
		~mate-extra/mate-system-monitor-9999:0
		~mate-extra/mate-utils-9999:0[gtk3(+)]
		~media-gfx/eom-9999:0[gtk3(+)] )
	netbook? ( ~mate-extra/mate-netbook-9999:0 )
	themes? ( ~x11-themes/mate-backgrounds-9999:0
		~x11-themes/mate-icon-theme-9999:0
		~x11-themes/mate-icon-theme-faenza-9999:0
		~x11-themes/mate-themes-9999:0 )
	user-guide? ( ~mate-extra/mate-user-guide-9999:0 )"
PDEPEND="virtual/notification-daemon:0"

S="${WORKDIR}"
