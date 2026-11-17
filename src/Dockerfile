# syntax=docker/dockerfile:1
FROM debian:unstable

ENV USER_NAME="opencode"
ENV DEBIAN_FRONTEND="noninteractive"
ENV OPENCODE_EXPERIMENTAL_FILEWATCHER=1

RUN <<_EOF_
apt-get update
apt-get install \
    --assume-yes \
    --no-install-recommends \
    "ca-certificates" \
    "cabal-install" \
    "git" \
    "jq" \
    "nodejs" \
    "npm" \
    "python3" \
    "python3-pip" \
    "python3.14-venv"

npm install --global --allow-scripts "opencode-ai" "opencode-ai@latest"
_EOF_

COPY "./opentofu.sources" "/etc/apt/sources.list.d"
COPY "./opentofu.gpg" "./opentofu-repo.gpg" "/etc/apt/keyrings/"
RUN <<_EOF_
apt-get update
apt-get install \
    --assume-yes \
    --no-install-recommends \
    "tofu"
_EOF_

RUN <<_EOF_
groupadd --gid 1000 "${USER_NAME}"
useradd --create-home --uid 1000 --gid 1000 "${USER_NAME}"
_EOF_

WORKDIR "/mnt"
USER 1000
ENV VIRTUAL_ENV="/home/${USER_NAME}/.venv"
RUN <<_EOF_
python3 -m venv "${VIRTUAL_ENV}"
_EOF_

ENV PATH="${VIRTUAL_ENV}/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
RUN <<_EOF_
python -m pip install --upgrade "pip"
python -m pip install "git+https://github.com/aws/aws-cli.git@v2"
printf "\n%s\n" 'PS1="(${VIRTUAL_ENV##*/}) ${PS1}"' >> "${HOME}/.bashrc"
_EOF_

ENTRYPOINT ["opencode"]
