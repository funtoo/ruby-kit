# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="NEWS.md README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="REXML is an XML toolkit for Ruby"
HOMEPAGE="https://github.com/ruby/rexml"
SRC_URI="https://github.com/ruby/rexml/tarball/a622645e980ea5b91ad7b4d6fec32d113f15df88 -> rexml-3.2.5-a622645.tar.gz"

KEYWORDS="*"
LICENSE="BSD-2"
SLOT="3"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-rexml-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -i -e 's:require_relative ":require "./:' -e 's/__dir__/"."/' ${RUBY_FAKEGEM_GEMSPEC} || die
	sed -i -e '/bundler/I s:^:#:' Rakefile || die
}

each_ruby_test() {
	${RUBY} test/run.rb || die
}