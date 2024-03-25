# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_EXTRADOC="NEWS.md README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="RSS reading and writing"
HOMEPAGE="https://github.com/ruby/rss"
SRC_URI="https://github.com/ruby/rss/tarball/f4e99c629c24bd4205d9969d842f7bc3e9954b8a -> rss-0.3.0-f4e99c6.tar.gz"

LICENSE="BSD-2"
KEYWORDS="*"
SLOT="0"
IUSE="test"

ruby_add_rdepend "dev-ruby/rexml"
ruby_add_bdepend "test? ( dev-ruby/test-unit )"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
	        mv "${WORKDIR}"/all/ruby-rss-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -i -e '/bundler/,/^helper.install/ s:^:#:' Rakefile || die
	sed -i -e 's:_relative ": "./:' ${RUBY_FAKEGEM_GEMSPEC} || die
}