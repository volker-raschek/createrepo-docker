# createrepo-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/volkerraschek/createrepo)](https://hub.docker.com/r/volkerraschek/createrepo)

This project contains all sources to build the container image
`docker.io/volkerraschek/createrepo` and the shell script `createrepo.sh`.

The primary goal of this project is to package the binary `createrepo` as
container image to provide the functionally for CI/CD workflows or for systems
which does contains the binary.

## createrepo.sh

The shell script `createrepo.sh` is a wrapper for the binary `createrepo`, which
is not available depending on the distribution. It starts the container image
`docker.io/volkerraschek/createrepo` in the background to call the binary. For
this reason, a container runtime like `docker` or `podman` is necessary.

### Installation

The script can be installed via the following command:

```bash
curl https://git.cryptic.systems/volker.raschek/createrepo-docker/raw/branch/master/createrepo.sh --output - | sudo tee /usr/local/bin/createrepo.sh && sudo chmod +x /usr/local/bin/createrepo.sh
```

### Usage

The script forwards all arguments directly to the binary running inside the
container. For this reason, all arguments from the original binary can be used.

```bash
createrepo.sh --update .                  # Update local repository
createrepo.sh --update /var/www/my-repo   # Update repository based on specific path
```
