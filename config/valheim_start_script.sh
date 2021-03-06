#!/bin/bash

#change these
NAME="TEST_SERVER"
PORT="2456"
WORLD="TEST_WORLD"
PW="password"

#dont change these
DATA="/app/valheim"
SAVE_DIR="$DATA/_config"
APP_ID="892970"

cd $DATA
#change directory to location of game server files

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=$APP_ID

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.

echo "Starting server PRESS CTRL-C to exit"

./valheim_server.x86_64 -name $NAME -port $PORT -world $WORLD -password $PW -savedir $SAVE_DIR > /dev/null

export LD_LIBRARY_PATH=$templdpath
