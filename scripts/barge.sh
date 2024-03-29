#!/bin/bash
set -e
DIR=$( dirname "${BASH_SOURCE[0]}" )
echo "$DIR"

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

SEPARATE_DOCKER_COMPOSE="false"

ls -lRah --color

[ -d ./docker-compose-source ] && echo "Directory for docker-compose-source exists" && SEPARATE_DOCKER_COMPOSE="true"
[ -d ./github-source ] && echo "Directory for github-source exists" || echo "No github-source found!" && exit 101

if [ "$SEPARATE_DOCKER_COMPOSE" = "true" ];
then
   cd docker-compose-source 
else
   cd github-source 
fi

echo $SEPARATE_DOCKER_COMPOSE

find ./path -iname 'dockerfile' -type f || echo "No dockerfile found!" && exit 101

docker build -t $DOCKER_IMAGE_NAME .
docker image ls