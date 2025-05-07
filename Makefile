# CREATEREPO_VERSION
# Only required to install a specify version
CREATEREPO_VERSION?=0.20.1

# CONTAINER_RUNTIME
# The CONTAINER_RUNTIME variable will be used to specified the path to a
# container runtime. This is needed to start and run a container image.
CONTAINER_RUNTIME?=$(shell which podman)

# CREATEREPO_IMAGE_REGISTRY_NAME
# Defines the name of the new container to be built using several variables.
CREATEREPO_IMAGE_REGISTRY_NAME?=git.cryptic.systems
CREATEREPO_IMAGE_REGISTRY_USER?=volker.raschek

CREATEREPO_IMAGE_NAMESPACE?=${CREATEREPO_IMAGE_REGISTRY_USER}
CREATEREPO_IMAGE_NAME:=createrepo
CREATEREPO_IMAGE_VERSION?=latest
CREATEREPO_IMAGE_FULLY_QUALIFIED=${CREATEREPO_IMAGE_REGISTRY_NAME}/${CREATEREPO_IMAGE_NAMESPACE}/${CREATEREPO_IMAGE_NAME}:${CREATEREPO_IMAGE_VERSION}
CREATEREPO_IMAGE_UNQUALIFIED=${CREATEREPO_IMAGE_NAMESPACE}/${CREATEREPO_IMAGE_NAME}:${CREATEREPO_IMAGE_VERSION}

# BUILD CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/build
container-image/build:
	${CONTAINER_RUNTIME} build \
		--build-arg CREATEREPO_VERSION=${CREATEREPO_VERSION} \
		--file Dockerfile \
		--no-cache \
		--pull \
		--tag ${CREATEREPO_IMAGE_FULLY_QUALIFIED} \
		--tag ${CREATEREPO_IMAGE_UNQUALIFIED} \
		.

# DELETE CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/delete
container-image/delete:
	- ${CONTAINER_RUNTIME} image rm ${CREATEREPO_IMAGE_FULLY_QUALIFIED} ${CREATEREPO_IMAGE_UNQUALIFIED}
	- ${CONTAINER_RUNTIME} image rm ${BASE_IMAGE_FULL}

# PUSH CONTAINER IMAGE
# ==============================================================================
PHONY+=container-image/push
container-image/push:
	echo ${CREATEREPO_IMAGE_REGISTRY_PASSWORD} | ${CONTAINER_RUNTIME} login ${CREATEREPO_IMAGE_REGISTRY_NAME} --username ${CREATEREPO_IMAGE_REGISTRY_USER} --password-stdin
	${CONTAINER_RUNTIME} push ${CREATEREPO_IMAGE_FULLY_QUALIFIED}

# PHONY
# ==============================================================================
# Declare the contents of the PHONY variable as phony.  We keep that information
# in a variable so we can use it in if_changed.
.PHONY: ${PHONY}
