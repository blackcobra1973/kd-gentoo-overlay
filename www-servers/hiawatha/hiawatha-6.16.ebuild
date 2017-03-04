DESCRIPTION="Advanced and secure webserver"
HOMEPAGE="http://www.hiawatha-webserver.org"
LICENSE="GPL"
KEYWORDS="amd64 x86"
SRC_URI="http://www.hiawatha-webserver.org/files/${P}.tar.gz"
SLOT="0"
IUSE="ssl ipv6 xslt cache toolkit logrotate"

RDEPEND="dev-libs/libxml2
	 ssl?  ( dev-libs/openssl ) 
	 xslt? ( dev-libs/libxslt )" 

DEPEND="${RDEPEND}"

pkg_setup() {
	if [[ -f /etc/hiawatha/httpd.conf ]] ; then
	    einfo "Renaming httpd.conf to hiawatha.conf"
	    mv /etc/hiawatha/httpd.conf /etc/hiawatha/hiawatha.conf
	fi
}


src_unpack() {
	unpack ${P}.tar.gz
	cd ${P}
	# Replace generated locations with the correct locations for a gentoo system.
	sed -i -e "s/@webrootdir@/\/var\/www\/localhost\/htdocs/" etc/hiawatha/hiawatha.conf.in
	sed -i -e "s/@logdir@/\/var\/log\/hiawatha/" etc/hiawatha/hiawatha.conf.in
}

src_compile() {
        econf \
                $(use_enable ipv6) \
                $(use_enable ssl) \
                $(use_enable xslt) \
		$(use_enable cache) \
		$(use_enable toolkit) \
                || die "econf failed"

	# Replace generated locations with the correct locations for a gentoo system.
	# Webroot dir
        sed -i -e "s/\/var\/lib\/www\/hiawatha/\/var\/www\/localhost\/htdocs/" config.h
	# Log dir
        sed -i -e "s/\/var\/lib\/log\/hiawatha/\/var\/log\/hiawatha/" config.h
	# Pid dir
	sed -i -e "s/\/var\/lib\/run/\/var\/run/" config.h
	# upload dir
	sed -i -e "s/\/var\/lib\/lib\/hiawatha/\/var\/lib\/hiawatha/" config.h


	emake || die "emake failed"
}

src_install() {

	into /usr
	dosbin hiawatha
	dosbin wigwam
	dosbin cgi-wrapper
	dosbin php-fcgi

	doman doc/hiawatha.1
	doman doc/wigwam.1
	doman doc/cgi-wrapper.1
	doman doc/php-fcgi.1

	exeinto /etc/init.d
	doexe ${S}/extra/php-fcgi

	# logrotate script
        if useq logrotate; then
            diropts -m0755
            insinto /etc/logrotate.d
            insopts -m0644
            newins "${S}"/etc/logrotate.d/hiawatha hiawatha
        fi

	insinto /etc/hiawatha
	doins  ${S}/etc/hiawatha/hiawatha.conf
	doins  ${S}/etc/hiawatha/cgi-wrapper.conf
	doins  ${S}/etc/hiawatha/mimetype.conf
	doins  ${S}/etc/hiawatha/php-fcgi.conf

	insinto /var/www/localhost/htdocs
	doins ${S}/doc/index.html
	
	newinitd "${FILESDIR}"/hiawatha hiawatha
	newinitd "${FILESDIR}"/php-fcgi php-fcgi
	
	keepdir /var/l{ib,og}/hiawatha /var/www/localhost/htdocs
}

pkg_postinst () {
	elog "Starting version 6.16 /etc/hiawatha/httpd.conf is renamed into /etc/hiawatha/hiawatha.conf"
	elog ""
        elog "Before starting hiawatha modify /etc/hiawatha/hiawatha.conf"
	elog "Before startian php-fcgi modify /etc/hiawatha/php-fcgi.conf"
}
		
