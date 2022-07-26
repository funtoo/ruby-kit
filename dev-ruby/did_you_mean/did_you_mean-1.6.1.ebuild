# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_RECIPE_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="The gem that has been saving people from typos since 2014"
HOMEPAGE="https://github.com/yuki24/did_you_mean"
SRC_URI="https://rubygems.org/downloads/did_you_mean-1.6.1.gem -> did_you_mean-1.6.1.gem"

KEYWORDS="*"
LICENSE="MIT"
SLOT="2.6"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest:5 )"

all_ruby_prepare() {
	sed -i -e '/bundler/ s:^:#:' Rakefile || die
}