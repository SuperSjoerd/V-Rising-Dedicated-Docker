#!/bin/sh

# Install the dedicated server using steamcmd in wine. This should only be done once!
cd /root/.wine/drive_c/steamcmd
if [ ! -e "./steaminstalled.txt" ]; then
    wincfg
    wine steamcmd.exe +force_install_dir "C:\VRisingServer" +login anonymous +app_update 1829350 validate +quit
    touch ./steaminstalled.txt
fi

# Fix XServer lock file
rm -r /tmp/.X0-lock
cd /root/.wine/drive_c/VRisingServer/

# Setup virtual framebuffer and start the VRisingServer.exe
Xvfb :0 -screen 0 1024x768x16 & \
DISPLAY=:0.0 wine VRisingServer.exe
