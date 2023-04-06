# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="minitest provides a complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking"
HOMEPAGE="https://github.com/seattlerb/minitest"
SRC_URI="https://rubygems.org/downloads/minitest-5.18.0.gem -> minitest-5.18.0.gem"

KEYWORDS="*"
LICENSE="MIT"
SLOT="5"
IUSE="doc test"

each_ruby_test() {
	MT_NO_PLUGINS=true ${RUBY} -Ilib:test:. -e "Dir['**/test_*.rb'].each{|f| require f}" || die "Tests failed"
}