#!/bin/bash
export NOCACHE=--no-cache
source $WORKSPACE/bin/env.sh

sudo podman rmi fhix/dbase2:$R_VERSION

sudo podman build \
--pull \
--no-cache \
--squash-all \
--tag=fhix/dbase2:$R_VERSION \
--build-arg R_VERSION=$R_VERSION \
--build-arg CRAN_CHECKPOINT=$CRAN_CHECKPOINT \
$WORKSPACE/dbase2

podman tag fhix/dbase2:$R_VERSION fhix/dbase:$R_VERSION
