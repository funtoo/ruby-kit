# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
USE_RUBY="ruby23 ruby24 ruby25"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Robust options validation for Ruby methods"
HOMEPAGE="https://github.com/durran/optionable"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
