ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:5.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Confiure locale
ENV \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/requirements.txt

# Setup base system
ARG BUILD_ARCH=amd64
# hadolint ignore=SC2181
# @todo implement strict dependency versioning
RUN \
    apt-get update \
    \
    && apt-get install -y \
    zsh \
    zip \
    wget \ 
    unzip \ 
    python3 \ 
    python3-dev \
    openssh-client \
    net-tools \
    locales \
    colordiff \
    git \
    openssl \
    python3 \
    python3-pip \
    python3-cryptography \
    less \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libfreetype6 \
    libxi6 \
    \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    \        
    && if [[ "${BUILD_ARCH}" = "aarch64" ]]; then ARCH="arm64"; fi \
    && if [[ "${BUILD_ARCH}" = "amd64" ]]; then ARCH="amd64"; fi \
    \
    && curl -L -s -o /usr/bin/ha \
    "https://github.com/home-assistant/cli/releases/download/4.12.3/ha_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/ha \
    \
    && git clone --branch master --single-branch --depth 1 \
    "git://github.com/robbyrussell/oh-my-zsh.git" ~/.oh-my-zsh \
    \
    && git clone --branch master --single-branch --depth 1 \
    "git://github.com/zsh-users/zsh-autosuggestions" \
    ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
    && git clone --branch master --single-branch --depth 1 \
    "git://github.com/zsh-users/zsh-syntax-highlighting.git" \
    ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
    \
    && sed -i -e "s#bin/bash#bin/zsh#" /etc/passwd \
    \
    && update-alternatives \
    --install /usr/bin/python python /usr/bin/python3 10 \
    \
    && pip3 install --no-cache-dir -r /tmp/requirements.txt 

# @todo implement proper cleaning
# \
#     && apt-get purge -y --auto-remove \
#         bsdtar \
#         build-essential \
#         python3-dev \
#         uuid-runtime \
#     \
#     && find /usr/local \
#         \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
#         -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
#         -exec rm -rf '{}' + \
#     \
#     && rm -fr \
#         /tmp/* \
#         /var/{cache,log}/* \
#         /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
# @todo fix sections below
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Fabio Ros <fabio@frosit.nl>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Fabio Ros <fabio@frosit.nl>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
