#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

DIR="/app/data"
if [ ! -d "$DIR" ]; then
  mkdir $DIR
fi
#create data folder in /app folder
#personal preference, avoids another volume mount in yml service

./valheim_server.x86_64 -nographics -batchmode -savedir $DIR "$@"

export LD_LIBRARY_PATH=$templdpath
#Why does this come last? export does need to be last though for server to work