#!/bin/sh
set -eu

BIN_DIR="/usr/local/bin/"
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/')

[ -z "$(command -v curl)" ] && echo 'curl must be installed' && exit 1
[ "$OS/$ARCH" != "linux/amd64" ] && [ "$OS/$ARCH" != "linux/arm64" ] && [ "$OS/$ARCH" != "darwin/amd64" ] && [ "$OS/$ARCH" != "darwin/arm64" ] && echo "Unsupported platform $OS/$ARCH. Supports linux/amd64 and linux/arm64." && exit 1

dl_url=$(curl -s https://api.github.com/repos/google/go-jsonnet/releases/latest | grep "browser_download_url" | grep -i "${OS}_${ARCH}.tar.gz" | cut -d : -f 2- | tr -d \")
tmpdir=$(mktemp -d)

curl -L $dl_url | tar xz -C "$tmpdir"

mv -f "${tmpdir}/jsonnet" ${BIN_DIR}
mv -f "${tmpdir}/jsonnetfmt" ${BIN_DIR}
mv -f "${tmpdir}/jsonnet-lint" ${BIN_DIR}
mv -f "${tmpdir}/jsonnet-deps" ${BIN_DIR}

rm -rf "$tmpdir"

jsonnet --version
jsonnetfmt --version
jsonnet-lint --version
jsonnet-deps --version
