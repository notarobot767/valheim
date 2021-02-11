# Linux containerized Valheim dedicated server using Podman

## Purpose
This repository allows the user to run and manage a Valheim server using through containerization. This code is made with Podman on RHEL8 but can be adapted for Docker. The specific server configuration is created for my own home network, but please feel free to adapt it for your own specific needs.

## Important Files

### [update.sh](https://github.com/notarobot767/valheim/blob/master/update.sh)
Run this script to launch a SteamCMD container to download/update you server files.

### [run.sh](https://github.com/notarobot767/valheim/blob/master/run.sh)
Run this script to start an instance of your Valheim server.

### [config.conf](https://github.com/notarobot767/valheim/blob/master/config.conf)
Script to reference global variables for the above scripts. Edit the variable LOCAL_DATA to point where you will store your local files.
