#!/bin/sh
set -eu

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/')

[ -z "$(command -v curl)" ] && echo 'curl must be installed' && exit 1
[ "$OS/$ARCH" != "linux/amd64" ] && [ "$OS/$ARCH" != "linux/arm64" ] && echo "Unsupported platform $OS/$ARCH. Supports linux/amd64 and linux/arm64." && exit 1

dl_url=$(curl -s https://api.github.com/repos/dodopizza/google-jsonnet/releases/latest | grep "browser_download_url" | grep "${OS}-${ARCH}" | cut -d : -f 2- | tr -d \")

cd /usr/local/bin/
curl -L $dl_url | tar xz

jsonnet --version
jsonnetfmt --version
