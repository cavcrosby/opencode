# syntax=docker/dockerfile:1
FROM debian:unstable

ENV USER_NAME="opencode"
ENV DEBIAN_FRONTEND="noninteractive"

RUN <<_EOF_
apt-get update
apt-get install \
    --assume-yes \
    --no-install-recommends \
    "cabal-install" \
    "git" \
    "jq" \
    "nodejs" \
    "npm"

npm install --global --allow-scripts "opencode-ai" "opencode-ai@latest"
_EOF_

RUN <<_EOF_
groupadd --gid 1000 "${USER_NAME}"
useradd --create-home --uid 1000 --gid 1000 "${USER_NAME}"
_EOF_

WORKDIR "/mnt"
USER 1000
ENTRYPOINT ["opencode"]
