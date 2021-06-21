#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/env.sh

sudo podman rmi fhix/dr:$R_VERSION

sudo podman build --pull --no-cache --tag=fhix/dr2:$R_VERSION --build-arg R_VERSION=$R_VERSION $WORKSPACE/dr2
podman tag fhix/dr2:$R_VERSION fhix/dr:$R_VERSION
