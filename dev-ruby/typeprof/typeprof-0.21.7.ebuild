# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_BINDIR="exe"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="An experimental type-level Ruby interpreter for testing and understanding Ruby code"
HOMEPAGE="https://github.com/ruby/typeprof"
SRC_URI="https://github.com/ruby/typeprof/tarball/35d311d1004b1723517921566ef13c3cb0928768 -> typeprof-0.21.7-35d311d.tar.gz"

KEYWORDS="*"
LICENSE="MIT"
SLOT="0"
IUSE="test"

ruby_add_rdepend ">=dev-ruby/rbs-1.8.1"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-typeprof-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	# Avoid tests that download live code using git
	rm -r test/typeprof/{goodcheck,diff-lcs}_test.rb || die

	sed -i -e "s:_relative ': './:" -e 's/git ls-files -z/find * -print0/' ${RUBY_FAKEGEM_GEMSPEC} || die
}