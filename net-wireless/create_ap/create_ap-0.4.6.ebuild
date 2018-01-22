# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1

DESCRIPTION="Script to create a NATed or Bridged WiFi Access Point"
HOMEPAGE="https://github.com/oblique/create_ap"
SRC_URI="https://github.com/oblique/create_ap/archive/v${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="app-shells/bash
	net-misc/bridge-utils
	net-wireless/hostapd
	|| ( net-wireless/iw
	net-wireless/wireless-tools )
	sys-apps/iproute2
	sys-apps/util-linux
	sys-process/procps"

RESTRICT="mirror"

DOCS=( "README.md" "howto" )

src_configure() {
	true
}

src_compile() {
	true
}

src_install() {
	exeinto /usr/bin
	doexe create_ap
	insinto /etc
	doins create_ap.conf
	insinto /usr/lib/systemd/system/
	doins create_ap.service
	newbashcomp bash_completion create_ap
	einstalldocs
}

pkg_postinst() {
	elog "To create 'NATed' or 'None' access point,"
	elog "be sure to install net-dns/dnsmasq and net-firewall/iptables"
}
