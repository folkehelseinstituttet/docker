#!/bin/bash
if [[ "$CI_PWD" == "" ]]; then
    export CI_PWD=$HOME/git/
fi

(echo y) | docker system prune

source $CI_PWD/docker/bin/R_VERSION.sh
docker push fhix/dbase:$RVERSION


