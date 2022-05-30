# https://stackoverflow.com/questions/61815364/how-can-i-get-my-win32-app-running-with-wine-in-docker
# WARNING: THIS IS ALL UNTESTED.

FROM ubuntu:latest

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y wine64 wine32 wget unzip xvfb && \
    rm -rf /var/lib/apt/lists/*
# Setup SteamCMD & VRising directories
RUN mkdir -p /root/.wine/drive_c/steamcmd && \
    mkdir -p /root/.wine/drive_c/users/root/AppData/LocalLow/'Stunlock Studios'/VRisingServer/Settings && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -P /root/.wine/drive_c/steamcmd/ && \
    cd /root/.wine/drive_c/steamcmd/ && \
    unzip steamcmd.zip && \
    mkdir -p /root/.wine/drive_c/VRisingServer/ && \
    cd /root/.wine/drive_c/steamcmd

# Copy startup script and make it executable
COPY root .
WORKDIR /scripts
RUN chmod +x ./run.sh

# Expose ports (see ServerHostSettings.json)
EXPOSE 27015/udp
EXPOSE 27016/udp

CMD ./run.sh
