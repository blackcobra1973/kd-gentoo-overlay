# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# Pluma supports Python2 only
PYTHON_COMPAT=( python2_7 )

inherit multilib python-single-r1

MY_PN="gedit-markdown"

DESCRIPTION="Support for Markdown in GtkSourceView and Pluma"
HOMEPAGE="https://github.com/jpfleury/gedit-markdown"
SRC_URI="https://github.com/jpfleury/${MY_PN}/archive/v1.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="2.0"
KEYWORDS=""
IUSE="pluma webkit"
REQUIRED_USE="webkit? ( pluma )"

DEPEND="app-arch/unzip"
RDEPEND="x11-libs/gtksourceview:${SLOT}
	pluma? ( ${PYTHON_DEPS}
		dev-python/markdown[${PYTHON_USEDEP}]
		!webkit? ( app-editors/pluma )
		webkit? ( <app-editors/pluma-1.17.0[python,${PYTHON_USEDEP}] ) )
	webkit? ( dev-python/pywebkitgtk[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_PN}-1"

RESTRICT="mirror"

src_prepare() {
	if use pluma ; then
		sed -e 's_#!/usr/bin/python_#!/usr/bin/python2_' \
			-e 's/gedit/pluma/g' \
			-e 's/Gedit/Pluma/g' \
			-i tools/export-to-html || die
	fi

	if use webkit ; then
		sed -e 's/Gedit Plugin/Pluma Plugin/'  \
			-i plugins/gedit2/markdown-preview.gedit-plugin || die
		sed -e 's_#!/usr/bin/python_#!/usr/bin/python2_' \
			-e 's/gedit/pluma/g' \
			-i plugins/gedit2/markdown-preview/__init__.py || die
	fi
}

src_compile() {
	# Due to install raw files, emake must be avoided.
	:
}

src_install() {
	insinto /usr/share/gtksourceview-${SLOT}
	doins -r language-specs styles
	dodoc README.md
	dodoc -r doc

	if use pluma ; then
		insinto /usr/share/pluma/plugins
		doins -r snippets

		exeinto /usr/share/pluma/plugins/externaltools/tools
		doexe tools/export-to-html
	fi

	if use webkit ; then
		newdoc config/gedit-markdown.ini pluma-markdown.ini.sample
		insinto /usr/$(get_libdir)/pluma/plugins
		newins plugins/gedit2/markdown-preview.gedit-plugin \
			markdown-preview.pluma-plugin
		doins -r plugins/gedit2/markdown-preview
	fi
}

pkg_postinst() {
	elog 'This package is originally for gedit 2 and named "gedit-markdown",'
	elog 'please remember that when you read the documents.'

	if use webkit ; then
		elog ''
		elog 'For setting the preview plugin,'
		elog 'please install pluma-markdown.ini to ~/.config/'
		elog "There is a sample file in /usr/share/doc/${PF}/"
	fi
}
