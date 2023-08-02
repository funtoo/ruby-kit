# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="The Ruby standard library package 'xmlrpc'"
HOMEPAGE="https://github.com/ruby/xmlrpc"
SRC_URI="https://github.com/ruby/xmlrpc/tarball/3f62b9106a999269a91281892867582e6e2b4ad3 -> xmlrpc-0.3.3-3f62b91.tar.gz"

KEYWORDS="*"
LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="0"
IUSE="test"

ruby_add_rdepend "dev-ruby/webrick"
ruby_add_bdepend "test? ( dev-ruby/test-unit )"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-xmlrpc-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -i -e '/bundler/ s:^:#:' Rakefile || die

	# Avoid dependency on git
	sed -i -e 's/git ls-files -z/find * -print0/' ${RUBY_FAKEGEM_GEMSPEC} || die
}