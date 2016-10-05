#!/usr/bin/env bash
# This script is used to dynamically update a docker-compose file when a docker is updated

VERSION_TAG=$1 
OWNER=$2
REPO_NAME=$3
DOCKER_IMAGE_NAME="$(echo $4 | sed -r 's/\//\\\//g')"
COMMIT_MESSAGE=$5
BRANCH=develop

git clone git@github.com:$OWNER/$REPO_NAME.git &&
cd $REPO_NAME &&
git checkout $BRANCH 

# Iterate through the provided files and update the Docker version tag in each
for var in "${@: 6}"
do
    echo "Updating $var with $VERSION_TAG"
    perl -pi -e "s/(?<=$DOCKER_IMAGE_NAME:)(\d.\d.\d)/$VERSION_TAG/g" $var
    git add $var
done

git commit -m "$COMMIT_MESSAGE" &&
git push


