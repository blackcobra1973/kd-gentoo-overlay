# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools toolchain-funcs

DESCRIPTION="Bind DynDB LDAP backend (replacement for sdb-ldap and dlz)"
HOMEPAGE="https://fedorahosted.org/bind-dyndb-ldap/"
SRC_URI="https://github.com/freeipa/bind-dyndb-ldap/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-dns/bind-9.11"
RDEPEND="${DEPEND}"

src_prepare() {
	# Fix for getsize method not implemented
	eapply "${FILESDIR}/bz1353563-11.1-r1.patch"

	eautoreconf

	eapply_user
}
