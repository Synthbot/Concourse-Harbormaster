#!/bin/bash
set -e
export TERM=dumb
DIR=$( dirname "${BASH_SOURCE[0]}" )
echo "$DIR"

# yell() { echo "$0: $*" >&2; }
# die() { yell "$*"; exit 111; }
# try() { "$@" || die "cannot $*"; }

# ls -lRah --color
echo "Present working directory: $PWD"

apt-get update

echo "Docker build started at: $date"

if [ -d ./docker-compose-source ]; then
   # Control will enter here if $DIRECTORY exists.
   echo "Directory for docker-compose-source exists"
   SEPARATE_DOCKER_COMPOSE="true"
else
   echo "No docker-compose-source found!"
   if [ -d ./docker-compose-source ]; then
      # Control will enter here if $DIRECTORY exists.
      echo "Directory for github-source exists"
      SEPARATE_DOCKER_COMPOSE="false"
   else
      echo "No github-source found!"
   fi
fi

echo "Separate Docker Compose: $SEPARATE_DOCKER_COMPOSE"

if [ "$SEPARATE_DOCKER_COMPOSE" = "true" ]; then
   cd ./docker-compose-source 
else
   cd ./github-source 
fi
apt-get install -y docker.io
echo "Present working directory: $PWD"

docker -v

if cmd [ find . -iname dockerfile -type f ]; then
   # Control will enter here if $DIRECTORY exists.
   echo "Directory for docker-compose-source exists"
else
   echo "No dockerfile found!"
fi

docker build -t "$DOCKER_IMAGE_NAME" .
docker image ls

echo "Docker build complete at: $date"