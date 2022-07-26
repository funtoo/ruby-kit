# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Provides telnet client functionality."
HOMEPAGE="https://github.com/ruby/net-telnet"
SRC_URI="https://github.com/ruby/net-telnet/tarball/8a900c1afa0f4d3810470b5e938e9c8431442daa -> net-telnet-0.2.0-8a900c1.tar.gz"

KEYWORDS="*"
LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="1"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/minitest )"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-net-telnet-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -i -e 's/git ls-files -z/find * -print0/' ${RUBY_FAKEGEM_GEMSPEC} || die

	sed -i -e '/bundler/ s:^:#:' Rakefile || die
}