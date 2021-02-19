#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/R_VERSION.sh

sudo podman rmi fhix/dr:$RVERSION

sudo podman build --pull --no-cache --tag=fhix/dr2:$RVERSION --build-arg RVERSION=$RVERSION $WORKSPACE/dr2
