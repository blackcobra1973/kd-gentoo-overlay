# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="ja"

inherit ltprune l10n

# these are needed for RC versions
MY_PV=${PV/_/}
MY_P="${PN}-${MY_PV}"

OSDN_DIR="66189"

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.sraoss.jp/"
SRC_URI="mirror://osdn/${PN}/${OSDN_DIR}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="crypt ipv6 ldap nls oniguruma pda spell ssl xface"

COMMON_DEPEND="x11-libs/gtk+:2
	crypt? ( app-crypt/gpgme )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	oniguruma? ( dev-libs/oniguruma )
	pda? ( app-pda/jpilot )
	spell? ( app-text/gtkspell:2 )
	ssl? ( || ( dev-libs/openssl:0
		dev-libs/libressl ) )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	linguas_ja? ( app-i18n/nkf )
	xface? ( media-libs/compface )"
RDEPEND="${COMMON_DEPEND}
	app-misc/mime-types
	net-misc/curl"

# for RC versions
S="${WORKDIR}/${MY_P%rc*}"
RESTRICT="mirror"

DOCS=( AUTHORS 'ChangeLog*' 'NEWS*' 'README*' 'TODO*' )

src_configure() {
	econf \
		--disable-updatecheck \
		--disable-updatecheckplugin \
		--with-manualdir=/usr/share/doc/${PF}/manual \
		--with-faqdir=/usr/share/doc/${PF}/faq \
		$(use_enable crypt gpgme) \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable oniguruma) \
		$(use_enable pda jpilot) \
		$(use_enable spell gtkspell) \
		$(use_enable ssl) \
		$(use_enable xface compface)
}

src_install() {
	emake DESTDIR="${ED}" install

	if use linguas_ja ; then
		# documents in Japanese are in EUC-JP, should be converted to UTF-8
		for fn in *.ja* manual/ja/* ; do
			nkf -w --overwrite ${fn}
		done
	fi

	dodoc ${DOCS[@]}

	#  In the tarball, "PLUGIN.txt" is named for case-insensitive systems,
	# because "PLUGIN" will conflict with "plugin" directory.
	#  Therefore, let's rename "PLUGIN.txt" to "PLUGIN".
	for fn in PLUGIN*.txt ; do
		newdoc ${fn} ${fn%.txt}
	done

	cd "${S}/plugin/attachment_tool"
	emake DESTDIR="${ED}" install-plugin
	docinto ""
	newdoc README PLUGIN-ATTACHMENT_TOOL

	prune_libtool_files --modules
}

pkg_postinst() {
	if [ ${PV} == *rc* ] ; then
		elog "Note:"
		elog "  Though ${MY_PV%rc*} is shown as the version number,"
		elog " this is a Release Candidate of ${MY_PV%rc} ."
	fi
}
