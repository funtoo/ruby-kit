# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md SHORTCUTS.md"
RUBY_FAKEGEM_GEMSPEC=paint.gemspec

inherit ruby-fakegem

DESCRIPTION="Ruby gem for ANSI terminal colors 🎨︎ VERY FAST"
HOMEPAGE="https://github.com/janlelis/paint"
SRC_URI="https://github.com/janlelis/paint/tarball/3baf1b626aaa1658fef4b145b31eb8caa5e295b4 -> paint-2.3.0-3baf1b6.tar.gz"

KEYWORDS="*"
LICENSE="MIT"
SLOT="0"
IUSE="doc test"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/janlelis-paint-* "${S}"/all/"${P}" || die
	fi
}