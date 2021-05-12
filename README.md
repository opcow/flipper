# Flipper

#### Fluidd and Klipper containerized.
---
Built and tested on an AMD64 system. The klipper Dockerfile may need changes to build on ARM systems. 

Use environment variable MR_UPSTREAM to tell Fluidd where Moonraker is. If the variable is unset then it will point to 0.0.0.0:7125.

Build the images for docker-compose: `docker-compose build` or `COMPOSE_DOCKER_CLI_BUILD=1 docker-compose build`.


The following examples use my host ip and printer device. You will have to copy your printer.cfg and any other needed config files into flipper/klipper/config_files.

Get flipper
---
    $ git clone https://github.com/opcow/flipper.git
    $ cd flipper


CLI
---
    $ build -t flipper-fluidd ./flipper
    $ docker run -d \
    --name fluidd \
    -p 80:80 \
    -e MR_UPSTREAM=192.168.4.9:7125 \
    --restart unless-stopped \
    flipper-fluidd

    $ build -t flipper-klipper ./klipper
    $ docker run -d \
    -p 7125:7125 \
    --device /dev/serial/by-id/usb-Klipper_lpc1769_20F0FF0B28813AAF13826A5CC02000F5-if00 \
    flipper-klipper

docker-compose
---
#### Replacing the variables for the device and upstream address with sed

Build:

    $ sed -i "s|\${PRINTER_DEV}|/dev/serial/by-id/usb-Klipper_lpc1769_20F0FF0B28813AAF13826A5CC02000F5-if00|" docker-compose.yaml
    $ sed -i "s|\${MR_UPSTREAM}|192.168.4.9:7125|" docker-compose.yaml
    $ docker-compose build

Run:

    $ docker-compose up -d

#### Leaving the variables in place, passing them on the command line

Build:

    $ docker-compose build

Run:

    $ PRINTER_DEV=/dev/serial/by-id/usb-Klipper_lpc1769_20F0FF0B28813AAF13826A5CC02000F5-if00 \
    MR_UPSTREAM=192.168.4.9:7125 \
    docker-compose up -d

#### Or export the variables in your shell

    export PRINTER_DEV=/dev/serial/by-id/usb-Klipper_lpc1769_20F0FF0B28813AAF13826A5CC02000F5-if00
    export MR_UPSTREAM=192.168.4.9:7125

    $ docker-compose up -d
