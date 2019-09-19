#!/usr/bin/env bash

export IP=192.168.99.100
export APP=custom-sso
export PROJECT=$APP-build

oc login https://${IP}:8443 -u system -p admin

oc delete project $PROJECT
oc new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project $PROJECT 2> /dev/null
done

oc  project $PROJECT

oc delete all -l app=$APP

oc new-app -f docker-build-template.yaml \
    -p APPLICATION_NAME=custom-sso \
    -p SOURCE_REPOSITORY_URL="https://github.com/primashah/custom-sso.git" \
    -p SOURCE_REPOSITORY_REF="master" \
    -p DOCKERFILE_PATH="build" \
    -p DOCKERFILE_NAME="Dockerfile"

oc start-build custom-sso-docker-build --follow


