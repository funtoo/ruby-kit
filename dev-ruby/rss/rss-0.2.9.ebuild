# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_EXTRADOC="NEWS.md README.md"

inherit ruby-fakegem

DESCRIPTION="RSS reading and writing "
HOMEPAGE="https://github.com/ruby/rss"
SRC_URI="https://rubygems.org/downloads/rss-0.2.9.gem -> rss-0.2.9.gem"

LICENSE="BSD-2"
KEYWORDS="*"
SLOT="0"
IUSE="test"

ruby_add_rdepend "dev-ruby/rexml"
ruby_add_bdepend "test? ( dev-ruby/test-unit )"

all_ruby_prepare() {
	sed -i -e '/bundler/,/^helper.install/ s:^:#:' Rakefile || die
}