FROM debian:bookworm-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG TERRARIA_VERSION="1.4.4.9"
ENV TERRARIA_VERSION="${TERRARIA_VERSION}"

ENV DEBUG_ENTRYPOINT=0
ENV DISABLE_COLORS=0
ENV DISABLE_SUMMARY=0
ENV TZ="UTC"

# general parameters
# https://terraria.fandom.com/wiki/Server#Server_config_file
ENV TERRARIA_AUTOCREATE=3
ENV TERRARIA_BANLIST="/data/banlist.txt"
ENV TERRARIA_DIFFICULTY=0
ENV TERRARIA_LANGUAGE="en-US"
ENV TERRARIA_MAXPLAYERS=8
ENV TERRARIA_MOTD="Please don't cut the purple trees!"
ENV TERRARIA_NPCSTREAM=60
ENV TERRARIA_PASSWORD=""
ENV TERRARIA_PORT=7777
ENV TERRARIA_PRIORITY=1
ENV TERRARIA_SECURE=1
ENV TERRARIA_SEED=""
ENV TERRARIA_UPNP=1
ENV TERRARIA_WORLD="/data/worlds/World.wld"
ENV TERRARIA_WORLDNAME=World
ENV TERRARIA_WORLDPATH="/data/worlds/"

# journey parameters
ENV TERRARIA_JOURNEYPERMISSION_BIOMESPREAD_SETFROZEN=2
ENV TERRARIA_JOURNEYPERMISSION_GODMODE=2
ENV TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE=2
ENV TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN=2
ENV TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH=2
ENV TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY=2
ENV TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE=2
ENV TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN=2
ENV TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK=2
ENV TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN=2
ENV TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT=2
ENV TERRARIA_JOURNEYPERMISSION_TIME_SETNOON=2
ENV TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED=2
ENV TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN=2
ENV TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH=2

# command-line parameters
# https://terraria.fandom.com/wiki/Server#Command_line_parameters
ENV TERRARIA_ANNOUNCEMENTBOXRANGE=""
ENV TERRARIA_DISABLEANNOUNCEMENTBOX=""
ENV TERRARIA_FORCEPRIORITY=""
ENV TERRARIA_IP=""
ENV TERRARIA_LOBBY=""
ENV TERRARIA_STEAM=0

WORKDIR /tmp/
# hadolint ignore=DL3003
RUN groupadd --gid 1000 terraria \
  && useradd --uid 1000 --gid terraria --shell /bin/bash --create-home terraria \
  && apt-get update \
  && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates="20230311" \
    tmux="3.3a-3" \
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

COPY ./entrypoint/ /opt/entrypoint/
RUN chmod +x /opt/entrypoint/entrypoint.sh

USER terraria
WORKDIR /opt/terraria/
EXPOSE 7777

ENTRYPOINT ["/opt/entrypoint/entrypoint.sh"]
CMD ["/opt/terraria/TerrariaServer.bin.x86_64", "-config", "/data/config.txt"]
