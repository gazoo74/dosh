# Maintainer: Gaël PORTAY <gael.portay@gmail.com>

pkgname=dosh
pkgver=1.7.1
pkgrel=1
pkgdesc='Docker shell'
arch=('any')
url="https://github.com/gportay/$pkgname"
license=('MIT')
depends=('docker')
makedepends=('asciidoctor')
checkdepends=('shellcheck')
source=("https://github.com/gportay/$pkgname/archive/$pkgver.tar.gz")
md5sums=('fa7651056ab0c68d60738e5cd8ab6386')
validpgpkeys=('8F3491E60E62695ED780AC672FA122CA0501CA71')

build() {
	cd "$pkgname-$pkgver"
	make doc SHELL="/bin/sh"
}

check() {
	cd "$pkgname-$pkgver"
	make -k check
}

package() {
	cd "$pkgname-$pkgver"
	make DESTDIR="$pkgdir" PREFIX="/usr" install install-doc
	install -D -m 644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
