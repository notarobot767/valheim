# Valheim Dedicated Server
Utilizing Linux and Docker Containers

Dedicated to my best friend on Discord, Joseph

## System Requirements
This server software was installed in a Ubuntu 22.04 Docker container. Since the server is a container, the host operating system could theoretically be any distribution of Linux that supports Docker and Docker Compose. Git was also used to clone the repository.

## Prerequisites
### 1. Linux host machine or VM to Install Server
I recommend [Ubuntu Server](https://ubuntu.com/download/server) without a GUI. If you prefer a desktop, I recommend [Linux Mint](https://linuxmint.com/download.php).

### 2. Install Docker Engine and Docker Compose
Follow [official guide](https://docs.docker.com/engine/install/ubuntu/). Test installation with version command for Docker and Docker Compose. Output should represent the most current version.
```
docker -v
```
> Docker version 24.0.2, build cb74dfc
```
docker compose version
```
> Docker Compose version v2.18.1

## Clone the Repository
Install git if not already installed
```
sudo apt install -y git
```
Clone the unturned repository to your current location
```
git clone https://github.com/notarobot767/unturned.git
```

## Setup Server Variables
Change directory into the newly cloned repository folder. The default name is called unturned.
```
cd unturned
```
Optional: edit the [.env](.env) file, and set the path to store persistent server data. The default is the local directory, data.

> UNTURNED_DATA_DIR="./data"

> #edit these variables to match your server

## Usage
I have supplied a series of scripts to help with server management.

[update.sh](update.sh) |
[run.sh](run.sh) |
[stop.sh](stop.sh) |
[restart.sh](restart.sh) | 
[update_run_headless.sh](update_run_headless.sh)

They are intended as a draft to point server admins in the right direction. Edit them to fit your needs for automation. Refer to the official documentation and learn the docker compose.

[Docker Compose File Version 3](https://docs.docker.com/compose/compose-file/compose-file-v3/) |
[Docker Compose CLI](https://docs.docker.com/compose/reference/)

### Update the Server
[update.sh](update.sh) will download the initial server files as well as apply any released updates. The launch parameters are included in command field of the [docker-compose.yml](docker-compose.yml) file and do not require modification.

The update may appear to freeze, but that is normal. This container will shutdown upon updating the server files.

```
sudo ./update.sh
```

### Run the Server
The server is built with the [Ubuntu Docker Image](https://hub.docker.com/_/ubuntu) 22.04 tag. Theoretically, other 64-bit Linux images would work, but I only tested it with Ubuntu. Other than updates, I only added the [ca-certificates](https://packages.ubuntu.com/jammy/ca-certificates), [libatomic1](), [libpulse-dev](), and [libpulse0]() packages in the [Dockerfile](Dockerfile) for the server. ca-certificates is necessary to TLS connections to communicate with Steam servers. The other packages are detailed as required in the [manual](Valheim%20Dedicated%20Server%20Manual.pdf). I am unaware of any other necessary packages to run Valheim on Linux.

If not already built, [run.sh](run.sh) will automatically build the server image. If you make any modifications to the Dockerfile, you will need to manually rebuild the image for any changes to take effect.

```
sudo docker compose build unturned_srv
```

Finally, run the server with
```
sudo ./run.sh
```

Upon startup, the server logs will be output to your screen with the docker compose logs command. Sending a break combination such as ctrl + c will stop the output but not the server. See Stop the Server.

### Stop the Server
To stop the server container, run the [stop.sh](stop.sh) script.
```
sudo ./stop.sh
```
> [+] Stopping 1/1

>  ✔ Container valheim-valheim_srv-1  Stopped

### Restart the Server
Restart the server using [restart.sh](restart.sh). This will NOT attach a screen instance on the given terminal; however, feel free to modify this script to do so. This is useful as [run.sh](run.sh) will not restart an already running server instance. This is true as long as the image was not rebuilt or parameters for valheim_srv in the [docker-compose.yml](docker-compose.yml) were not changed, updated, or removed.

```
sudo ./restart.sh
```
> [+] Restarting 1/1

> ✔ Container valheim-valheim_srv-1  Started

### Update and then Restart the Server
[update_run_headless.sh](update_run_headless.sh) will safely and without output, update then restart the server. This is ideally the kind of script to use for automation.

```
sudo ./update_run_headless.sh
```

## Customize the Server
### Port Forwarding
As specified in the [manual](Valheim%20Dedicated%20Server%20Manual.pdf), UDP ports 2456-2457 are used by default.

Ensure your router has a rule to forward these ports to your server when clients connect on your public IP address. If you are new to networking, read about the difference between public and private IP address and NAT. Essentially, your home network is likely a private IP address range, and your router has a single public IP address. Public addresses can talk on the internet while private addresses can't. NAT is the mechanism that allows your private addresses to masquerade as your router's single public IP address. Port forwarding is how we enable a public IP to initiate a connection to private IP address, in this case to your Unturned server.

### Server Runtime Options
Refer to the [manual](Valheim%20Dedicated%20Server%20Manual.pdf) for server runtime configuration options to include: name, world, password, etc. These options should be entered or modified in the [docker-compose.yml](docker-compose.yml) file valheim_srv service under the command field. They will then be passed into the [start_server_custom.sh](start_server_custom.sh) script ran at container instantiation.

For the changes to take affect, run the [run.sh](run.sh) script, and the server container will be rebuilt with these parameters.

### Valheim Config Files
As inferred from the file names, Valheim provides the server admin with: adminlist.txt, bannedlist.txt, and permittedlist.txt. These files are located in the local data folder within the folder data.