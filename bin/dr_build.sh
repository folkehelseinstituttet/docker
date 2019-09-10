#!/bin/bash
export NOCACHE=--no-cache

source $WORKSPACE/bin/R_VERSION.sh

docker build --pull --no-cache --tag=fhix/dr:$RVERSION --build-arg RVERSION=$RVERSION $WORKSPACE/dr
