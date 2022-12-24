# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.rdoc README.ja.rdoc TODO ChangeLog"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_EXTENSIONS=(ext/racc/cparse/extconf.rb)
RUBY_FAKEGEM_EXTENSION_LIBDIR="lib/racc/cparse"

inherit ruby-fakegem

DESCRIPTION="Racc is an LALR(1) parser generator.  It is written in Ruby itself, and generates ruby programs."
HOMEPAGE="https://github.com/ruby/racc"
SRC_URI="https://github.com/ruby/racc/tarball/8d1c1ed79e2c85ec54b9fb470f7171b34ae3b7e2 -> racc-1.6.2-8d1c1ed.tar.gz"

KEYWORDS="*"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc test"

ruby_add_rdepend "virtual/ruby-ssl"

ruby_add_bdepend "dev-ruby/rake
	test? ( dev-ruby/minitest )"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-racc-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -i -e 's/, :isolate//' Rakefile || die
	sed -i -e '/bundler/ s:^:#:' -e '/rdoc/,/^end/ s:^:#:' Rakefile || die

	# Avoid depending on rake-compiler since we don't use it to compile
	# the extension.
	sed -i -e '/rake-compiler/ s:^:#:' -e '/extensiontask/ s:^:#:' Rakefile
	sed -i -e '/ExtensionTask/,/^  end/ s:^:#:' Rakefile
	# Which means we need to generate the parser file here
	rake lib/racc/parser-text.rb || die

	sed -i -e 's:_relative ": "./:' ${RUBY_FAKEGEM_GEMSPEC} || die
}

all_ruby_install() {
	all_fakegem_install

	dodoc -r doc

	docinto examples
	dodoc -r sample
}