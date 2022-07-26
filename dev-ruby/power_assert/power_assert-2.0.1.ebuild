# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Power Assert for Ruby"
HOMEPAGE="https://github.com/ruby/power_assert"
SRC_URI="https://github.com/ruby/power_assert/tarball/1d21b6d68fb67c7b16f964d4c68ee9a288048e05 -> power_assert-2.0.1-1d21b6d.tar.gz"

KEYWORDS="*"
LICENSE="|| ( Ruby BSD-2 )"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/test-unit )"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-power_assert-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -i -e '/bundler/I s:^:#:' Rakefile test/test_helper.rb || die
	sed -i -e '1igem "test-unit"' \
		-e '/byebug/ s:^:#:' test/test_helper.rb || die

	# Avoid git dependency
	sed -i -e 's/git ls-files -z/find . -print0/' ${RUBY_FAKEGEM_GEMSPEC} || die

	# Avoid circular dependency on byebug when bootstrapping ruby
	sed -i -e '/byebug/ s:^:#:' -e '/test_core_ext_helper/ s:^:#:' test/test_helper.rb || die
	rm test/test_core_ext_helper.rb test/trace_test.rb || die

	# Avoid circular dependency on pry when bootstrapping ruby
	sed -i -e '/pry/ s:^:#:' -e '/test_colorized_pp/,/^    end/ s:^:#:' test/block_test.rb || die
}