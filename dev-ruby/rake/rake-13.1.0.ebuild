# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc TODO"
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_BINDIR="exe"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A make-like build utility for Ruby."
HOMEPAGE="https://github.com/ruby/rake"
SRC_URI="https://github.com/ruby/rake/tarball/5476cda5c368773c5198a7157d032fe4fc93d795 -> rake-13.1.0-5476cda.tar.gz"

KEYWORDS="*"
LICENSE="MIT"
SLOT="0"
IUSE="doc"

DEPEND+=" app-arch/gzip"

ruby_add_bdepend "test? ( >=dev-ruby/minitest-5.8 )
	doc? ( dev-ruby/rdoc )"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-rake-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -e 's/git ls-files -z/find * -type f -print0/' \
		-e 's:_relative ": "./:' \
		-i ${RUBY_FAKEGEM_GEMSPEC} || die
}

all_ruby_compile() {
	if use doc; then
		rdoc --title "Rake - Ruby Make" --main README.rdoc --out html lib *.rdoc doc/*/*.rdoc || die
		rm -f html/js/*.js.gz
	fi
}

each_ruby_test() {
	${RUBY} -Ilib:test:. -e 'gem "minitest", "~>5.8"; require "minitest/autorun"; Dir["test/test_*.rb"].each{|f| require f}' || die
}

all_ruby_install() {
	ruby_fakegem_binwrapper rake

	if use doc; then
		pushd html
		dodoc -r *
		popd
	fi

	doman doc/rake.1
}