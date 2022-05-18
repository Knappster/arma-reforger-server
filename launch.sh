#!/usr/bin/env bash

set -uxe

echo "Downloading Arma Reforger Server."
$STEAMCMD_PATH/steamcmd.sh +force_install_dir $ARMA_PATH +login anonymous +app_update 1874900 validate +quit

echo "Starting Arma Reforger Server."
cd $ARMA_PATH
./ArmaReforgerServer -gproj ./addons/data/ArmaReforger.gproj -config $CONFIG_PATH -backendlog -nothrow -profile $HOME_PATH/profile
