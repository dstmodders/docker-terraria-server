FROM debian:bookworm-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG TERRARIA_VERSION="1.4.4.9"
ENV TERRARIA_VERSION="${TERRARIA_VERSION}"

ARG TERRARIA_TSHOCK_VERSION="5.2.0"
ENV TERRARIA_TSHOCK_VERSION="${TERRARIA_TSHOCK_VERSION}"

ENV TZ="UTC"

WORKDIR /tmp/
# hadolint ignore=DL3003
RUN groupadd --gid 1000 terraria \
  && useradd --uid 1000 --gid terraria --shell /bin/bash --create-home terraria \
  && dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates="20230311" \
    gnupg="2.2.40-1.1" \
    gpg="2.2.40-1.1" \
    unzip="6.0-28" \
    wget="1.21.3-1+b2" \
  # change timezone
  && ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime \
  && echo "${TZ}" > /etc/timezone \
  # add Microsoft apt sources
  && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
  && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
  && echo "deb [arch=amd64] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/dotnet.list \
  # install .NET runtime
  && apt-get update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
    dotnet-runtime-6.0="6.0.27-1" \
  # download and install Terraria
  && export TERRARIA_TSHOCK_DOWNLOAD_FILE="TShock-${TERRARIA_TSHOCK_VERSION%.*}-for-Terraria-${TERRARIA_VERSION}-linux-x64-Release.zip" \
  && wget -q "https://github.com/Pryaxis/TShock/releases/download/v${TERRARIA_TSHOCK_VERSION}/${TERRARIA_TSHOCK_DOWNLOAD_FILE}" \
  && unzip "${TERRARIA_TSHOCK_DOWNLOAD_FILE}" \
  && mkdir /opt/tshock/ \
  && tar -xvf TShock-Beta-linux-x64-Release.tar -C /opt/tshock/ \
  && rm -Rf /tmp/* \
  && cd /opt/tshock/ \
  && chown -R terraria:terraria . \
  && chmod +x TShock.* \
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

COPY ./entrypoint/ /opt/entrypoint/
RUN chmod +x /opt/entrypoint/entrypoint.sh

USER terraria
WORKDIR /opt/tshock/
EXPOSE 7777 7878

ENTRYPOINT ["/opt/entrypoint/entrypoint.sh"]
CMD ["/opt/tshock/TShock.Server"]
