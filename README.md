# Linux containerized Valheim dedicated server using Podman

## Purpose
This repository allows the user to run and manage a Valheim server using through containerization. This code is made with Podman on RHEL8 but can be adapted for Docker. The specific server configuration is created for my own home network, but please feel free to adapt it for your own specific needs.

## Flow of Operation
<b>update.sh:</b> download/update the server files

<b>build.sh:</b> build the image to run the server in a container

<b>run.sh:</b> start/restart the server

## Important Files

### [config.sh](https://github.com/notarobot767/valheim/blob/master/config/config.sh)
Script to reference global variables for the above scripts. You should edit this file manipulate the program. The only variable that will need to be changed before use is LOCAL_DATA. Edit this variable to point where you will store your game local files. Other varibles you might consider editing would be the image used to build the Valheim image, name of container, the server ports.

### [update.sh](https://github.com/notarobot767/valheim/blob/master/update.sh)
Run this script to launch a SteamCMD container to download/update you server files. You should not edit this file. This script will create a container based off the [SteamCMD](https://hub.docker.com/r/steamcmd/steamcmd) image to download your Valheim server files to your specified mounted directory with the variable LOCAL_DATA in config.sh. The container will run the SteamCMD CLI on the mounted file [valheim_update_script.conf](https://github.com/notarobot767/valheim/blob/master/config/valheim_update_script.conf). For a more detailed manual of SteamCMD, check out the Valve CLI [manuel](https://developer.valvesoftware.com/wiki/Command_Line_Options).

### [build.sh](https://github.com/notarobot767/valheim/blob/master/build.sh)
Run this script to build the image that will be used in running the server. I used Ubuntu, but other linux builds should work as well. The [website](https://linuxgsm.com/lgsm/vhserver/) Linux Game Server Managers recommend either Ubuntu, Debian, or Centos. My [dockerfile](https://github.com/notarobot767/valheim/blob/master/config/dockerfile.conf) downloads the latest Ubunutu image, updates it, copies the [valhiem_start_script.sh](https://github.com/notarobot767/valheim/blob/master/config/valheim_start_script.sh), and creates an entrypoint for the start script. View the reference [manual](https://docs.docker.com/develop/develop-images/dockerfile_best-practices) if you want to change this.

### [run.sh](https://github.com/notarobot767/valheim/blob/master/run.sh)
Run this script to start a container instance of your Valheim server. You must have ran build.sh at least once before running run.sh. At this point, you can control the image with the necessary Podman/Docker stop or restart commands, ex. sudo podman restart valhiem. So if you need to update your server files, update.sh will automatically stop the container, but you should restart the container with a Podman restart command. Also, I set the Podman run command to run in detached mode, meaning you will not see the output unless you change it from -d to -it.
