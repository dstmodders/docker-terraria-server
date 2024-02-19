FROM debian:bookworm-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG TERRARIA_VERSION="1.4.4.9"
ENV TERRARIA_VERSION="${TERRARIA_VERSION}"

ENV TZ="UTC"

WORKDIR /tmp/
# hadolint ignore=DL3003
RUN groupadd --gid 1000 terraria \
  && useradd --uid 1000 --gid terraria --shell /bin/bash --create-home terraria \
  && apt-get update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates="20230311" \
    unzip="6.0-28" \
    wget="1.21.3-1+b2" \
  # change timezone
  && ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime \
  && echo "${TZ}" > /etc/timezone \
  # download and install Terraria
  && export TERRARIA_DOWNLOAD_FILE="terraria-server-${TERRARIA_VERSION//./}.zip" \
  && wget -q "https://terraria.org/api/download/pc-dedicated-server/${TERRARIA_DOWNLOAD_FILE}" \
  && unzip "${TERRARIA_DOWNLOAD_FILE}" \
  && mv "${TERRARIA_VERSION//./}/Linux/" /opt/terraria/ \
  && rm -Rf /tmp/* \
  && cd /opt/terraria/ \
  && chown -R terraria:terraria . \
  && chmod +x TerrariaServer* \
  # clean
  && apt-get remove -y \
    ca-certificates \
    unzip \
    wget \
  && cd /tmp/ \
  && apt-get clean \
  && apt-get autoremove -y \
  && rm -Rf \
    /etc/ca-certificates.conf \
    /etc/ssl/ \
    /etc/wgetrc \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/log/alternatives.log \
    /var/log/apt/ \
    /var/log/dpkg.log

USER terraria
WORKDIR /opt/terraria/
EXPOSE 7777

CMD ["/opt/terraria/TerrariaServer.bin.x86_64"]
