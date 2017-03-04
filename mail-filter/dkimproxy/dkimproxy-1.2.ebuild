# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="An SMTP-proxy that signs and/or verifies emails, using the
Mail::DKIM module."
HOMEPAGE="http://dkimproxy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-perl/Mail-DKIM-0.30
		dev-perl/Error
		>=dev-perl/net-server-0.91"
RDEPEND="${DEPEND}"

src_compile(){
	econf || die "econf failed."
	emake || die "emake failed."
}

src_install(){
	emake DESTDIR="${D}" install || die "emake install failed."
	exeinto /etc/init.d
	newexe ${FILESDIR}/dkimproxy_in.rc dkimproxy_in
	newexe ${FILESDIR}/dkimproxy_out.rc dkimproxy_out
}


