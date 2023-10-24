# jsonnet
Static compiled jsonnet binaries. Supports linux/amd64 and linux/arm64 platform


### Quick install latest version

```
curl -sL https://dodopizza.github.io/google-jsonnet/dl.sh | bash
```

### Manuall install

```shell
version=0.20.0
platform=arm64
curl -L https://github.com/dodopizza/google-jsonnet/releases/download/v${version}/jsonnet-v${version}-linux-${platform}.tar.gz | tar xz
mv -f jsonnet* /usr/local/bin/
```

### Dockerfile example

```dockerfile
FROM ubuntu:jammy

# must be amd64 or arm64
ARG TARGETARCH

# Install base packages
RUN apt update && apt install -y curl && apt clean

# Jsonnet
RUN curl -sL https://dodopizza.github.io/google-jsonnet/dl.sh | bash
```

```shell
docker buildx build --platform linux/arm64,linux/amd64 -t jsonnet:latest .
```
