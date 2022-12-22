# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_EXTRADOC="README.md doc-install/text/*.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="test-unit"
HOMEPAGE="https://github.com/test-unit/test-unit"
SRC_URI="https://github.com/test-unit/test-unit/tarball/ebd4c197f05ca1e34252c9c004793391423645bc -> test-unit-3.5.7-ebd4c19.tar.gz"

KEYWORDS="*"
LICENSE="|| ( Ruby GPL-2 ) PSF-2"
SLOT="2"
IUSE="doc test"

ruby_add_rdepend "dev-ruby/power_assert"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/test-unit-test-unit-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	mv doc doc-install || die "moving doc directory out of the way failed"
}

each_ruby_test() {
	${RUBY} test/run-test.rb || die "testsuite failed"
}

all_ruby_install() {
	all_fakegem_install
}