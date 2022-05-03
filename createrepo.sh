#!/bin/bash

set -e

CONTAINER_RUNTIME=$(which docker)

CREATEREPO_IMAGE_REGISTRY_HOST=docker.io
CREATEREPO_IMAGE_NAME=volkerraschek/createrepo
CREATEREPO_IMAGE_VERSION=0.17.1
CREATEREPO_IMAGE_FULLY_QUALIFIED=${CREATEREPO_IMAGE_REGISTRY_HOST}/${CREATEREPO_IMAGE_NAME}:${CREATEREPO_IMAGE_VERSION}

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
