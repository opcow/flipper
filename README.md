# Flipper

Fluidd and Klipper containerized.

Use environment variable UPSTREAM to tell Fluidd where Moonraker is. If the variable is unset then it will point to 0.0.0.0:7125.

Build the images for docker-compose: `docker-compose build` or `COMPOSE_DOCKER_CLI_BUILD=1 docker-compose build`

The Fluidd image can be used to run a container on a separate machine from Klipper and Moonraker. For example, I have Fluidd, Klipper, and Moonraker all running on an AMD64-based machine that my printer is connected to (IP adress 192.168.4.9), but I also have a container using the Fuidd image running on a Raspberry Pi 0w (IP address 192.168.3.7) using the following CLI command:

    docker run -d \
    --name fluidd \
    -p 80:80 \
    -e UPSTREAM=192.168.4.9:7125 \
    --restart unless-stopped \
    flipper/fluidd

The Raspberry Pi only serves the Fluidd web UI. Files uploaded from Cura or PrusaSlicer via the Fluidd UI at 192.168.3.7 go directly to the AMD64 machine at 192.168.4.9. The Raspberry Pi isn't involved in the handling of gcode files and printing.