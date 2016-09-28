#!/bin/bash
# This script is used to dynamically update a docker-compose file when a docker is updated

VERSION_TAG=$1 
OWNER=$2
REPO_NAME=$3
DOCKER_IMAGE_NAME="$(echo $4 | sed -r 's/\//\\\//g')"
COMPOSE_FILE_LOCATION=$5
COMMIT_MESSAGE=$6
BRANCH=develop

git clone git@github.com:$OWNER/$REPO_NAME.git &&
cd $REPO_NAME &&
git checkout $BRANCH &&

# Replace the pylon version with the new tag
perl -pi -e "s/(?<=$DOCKER_IMAGE_NAME:)(\d.\d.\d)/$VERSION_TAG/g" $COMPOSE_FILE_LOCATION &&

git add $COMPOSE_FILE_LOCATION &&
git commit -m "$COMMIT_MESSAGE" &&
git push 
