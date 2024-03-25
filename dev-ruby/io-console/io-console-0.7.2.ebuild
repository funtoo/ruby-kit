# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_EXTENSIONS=(ext/io/console/extconf.rb)
RUBY_FAKEGEM_EXTENSION_LIBDIR="lib/io"
RUBY_FAKEGEM_EXTRADOC="README.md"
 RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="add console capabilities to IO instance"
HOMEPAGE="https://github.com/ruby/io-console"
SRC_URI="https://github.com/ruby/io-console/tarball/1f2877a18512ec6d90d4d6d3d9d3fdf8095575a8 -> io-console-0.7.2-1f2877a.tar.gz"

LICENSE="BSD-2"
KEYWORDS="*"
SLOT="0"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/test-unit )"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
	        mv "${WORKDIR}"/all/ruby-io-console-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -e 's/__FILE__/"'${RUBY_FAKEGEM_GEMSPEC}'"/' \
		-e 's/__dir__/"."/' \
		-e 's/git ls-files -z/find * -print0/' \
		-i ${RUBY_FAKEGEM_GEMSPEC} || die
	sed -e '/task :test/ s:^:#:' -i Rakefile || die

	# Avoid test that require a proper TTY
	sed -e '/test_\(bad_keyword\|failed_path\)/aomit "requires TTY"' \
		-i test/io/console/test_io_console.rb || die

	# Remove ruby and ffi files in accordance with the gemspec. These
	# are only used when using a different ruby engine like jruby.
	rm -fr lib/io/console.rb lib/io/console/ffi || die
}

each_ruby_test() {
	${RUBY} -Ilib:.:test:test/lib -rhelper -e 'Dir["test/**/test_*.rb"].each{|f| require f}' || die
}