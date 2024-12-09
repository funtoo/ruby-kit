# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="HTTP server toolkit"
HOMEPAGE="https://github.com/ruby/webrick"
SRC_URI="https://github.com/ruby/webrick/tarball/307f24c0e9624e56fdbe8ebbe6df03ee25e9e57b -> webrick-1.9.1-307f24c.tar.gz"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-webrick-* "${S}"/all/"${P}" || die
	fi
}

KEYWORDS="*"
LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="0"
IUSE="test"

all_ruby_prepare() {
	sed -i -e "s:_relative ': './:" ${RUBY_FAKEGEM_GEMSPEC} || die
}