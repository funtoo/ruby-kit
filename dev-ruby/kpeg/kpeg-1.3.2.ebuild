# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="A simple PEG library for Ruby"
HOMEPAGE="https://github.com/evanphx/kpeg"
SRC_URI="https://rubygems.org/downloads/kpeg-1.3.2.gem -> kpeg-1.3.2.gem"

KEYWORDS="*"
LICENSE="MIT"
SLOT="1"
IUSE="test"

PATCHES=( "${REPODIR}/dev-ruby/files/${PN}/kpeg-1.1.0-utf8.patch" )

ruby_add_bdepend "test? ( dev-ruby/minitest:5 )"

each_ruby_test() {
	${RUBY} -Ilib:test:. -e 'gem "minitest", "~>5.0"; Dir["test/test_*.rb"].each{|f| require f}' || die
}