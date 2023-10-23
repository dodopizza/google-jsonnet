FROM alpine:3.10.3 AS jsonnet_builder
WORKDIR /workdir
ARG JSONNET_REPO_TAG='v0.20.0'
RUN apk -U add build-base git \
  && git clone --depth 1 --branch "${JSONNET_REPO_TAG}" https://github.com/google/jsonnet . \
  && export LDFLAGS=-static \
  && make
