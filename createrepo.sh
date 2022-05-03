#!/bin/bash

set -e

CONTAINER_RUNTIME=$(which docker)

CREATEREPO_IMAGE_FULLY_QUALIFIED=docker.io/volkerraschek/createrepo:0.17.1

CUSTOM_UID=$(getent passwd ${USER} | cut -d ':' -f 3)
CUSTOM_GID=$(getent passwd ${USER} | cut -d ':' -f 4)

# Extract last element of passed arguments
REPO_DIR=${@: -1}

${CONTAINER_RUNTIME} run \
  --rm \
  --volume ${REPO_DIR}:${REPO_DIR} \
  --workdir ${REPO_DIR} \
  --user ${CUSTOM_UID}:${CUSTOM_GID} \
  ${CREATEREPO_IMAGE_FULLY_QUALIFIED} ${@}
