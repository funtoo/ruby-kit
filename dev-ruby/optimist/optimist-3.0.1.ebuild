# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"

RUBY_FAKEGEM_EXTRADOC="FAQ.txt History.txt README.md"

inherit ruby-fakegem

DESCRIPTION="A commandline option parser for Ruby that just gets out of your way"
HOMEPAGE="https://manageiq.github.io/optimist/"

KEYWORDS="*"
LICENSE="MIT"
SLOT="3"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/bundle/ s:^:#:' Rakefile || die
}