#!/bin/bash

set -e

CONTAINER_RUNTIME=$(which docker)
CREATEREPO_IMAGE_VERSION=0.17.2

CUSTOM_UID=$(getent passwd ${USER} | cut -d ':' -f 3)
CUSTOM_GID=$(getent passwd ${USER} | cut -d ':' -f 4)

${CONTAINER_RUNTIME} run \
  --rm \
  --volume ${PWD}:${PWD} \
  --workdir ${PWD} \
  --user ${CUSTOM_UID}:${CUSTOM_GID} \
  docker.io/volkerraschek/createrepo:${CREATEREPO_IMAGE_VERSION} ${@}
