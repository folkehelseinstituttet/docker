#!/bin/bash
source $WORKSPACE/bin/env.sh
source /etc/environment

podman login docker.io -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

podman push fhix/dr:$R_VERSION

podman tag fhix/dr:$R_VERSION fhix/dr:latest
podman push fhix/dr:latest
