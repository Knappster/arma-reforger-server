FROM ubuntu:20.04

LABEL maintainer="Carl Knapp - github.com/knappster"

ARG PUID=1000
ARG USER=steam

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME_PATH="/home/${USER}"
ENV ARMA_PATH="${HOME_PATH}/arma_server"
ENV STEAMCMD_PATH="${HOME_PATH}/steamcmd"
ENV CONFIG_NAME="server-config.json"
ENV CONFIG_PATH="${HOME_PATH}/${CONFIG_NAME}"
ENV PROFILE_PATH="${HOME_PATH}/profile"

RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
	libcurl4 \
	libssl1.1 \
	lib32stdc++6 \
	lib32gcc-s1 \
	wget \
	ca-certificates \
	libsdl2-2.0-0:i386 \
	libtbb2 \
	libtbb2:i386 \
	zlib1g:i386 \
	&& useradd -u "$PUID" -m "$USER" \
	&& su "$USER" -c \
	"mkdir -p \"$ARMA_PATH\" \
	&& mkdir -p \"$STEAMCMD_PATH\" \
	&& mkdir -p \"$PROFILE_PATH\" \
	&& wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"$STEAMCMD_PATH\"" \
	&& apt-get remove --purge -y \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

USER $USER
WORKDIR $HOME_PATH

COPY --chown=$USER:$USER ./launch.sh ./launch.sh
COPY --chown=$USER:$USER ./$CONFIG_NAME $CONFIG_PATH

# https://community.bistudio.com/wiki/Arma_Reforger:Server_Hosting
EXPOSE 2001/udp
EXPOSE 50000-65000/udp
EXPOSE 17777/udp

VOLUME $HOME_PATH

ENTRYPOINT ["./launch.sh"]
