# Flipper

Fluidd and Klipper containerized.

Use environment variable UPSTREAM to tell Fluidd where Moonraker is. If the variable is unset then it will point to 0.0.0.0:7125.

Build the images for docker-compose: `docker-compose build` or `COMPOSE_DOCKER_CLI_BUILD=1 docker-compose build`.

CLI examples:

    # build -t flipper-fluidd ./flipper
    docker run -d \
    --name fluidd \
    -p 80:80 \
    -e UPSTREAM=192.168.4.9:7125 \
    --restart unless-stopped \
    flipper-fluidd

    # build -t flipper-klipper ./klipper
    docker run -d \
    -p 7125:7125 \
    --device /dev/serial/by-id/usb-Klipper_lpc1769_20F0FF0B28813AAF13826A5CC02000F5-if00 \
    flipper-klipper
