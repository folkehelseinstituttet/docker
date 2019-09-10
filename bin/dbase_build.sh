#!/bin/bash
export NOCACHE=--no-cache
if [[ "$CI_PWD" == "" ]]; then
    export CI_PWD=$HOME/Documents/git/
    export NOCACHE=" "
fi

source $CI_PWD/docker/bin/R_VERSION.sh


docker build --pull --no-cache --squash --tag=fhix/dbase:$RVERSION --build-arg RVERSION=$RVERSION $CI_PWD/docker/dbase
