FROM docker.io/library/rockylinux:9.3.20231119

ARG CREATEREPO_VERSION

RUN yum update --assumeyes && \
    yum install --assumeyes bash bash-completion

RUN if [ -z ${CREATEREPO_VERSION+x} ]; then \
      yum install --assumeyes createrepo_c; \
    else \
      yum install --assumeyes createrepo_c-${CREATEREPO_VERSION}; \
    fi

ENTRYPOINT [ "/usr/bin/createrepo" ]
