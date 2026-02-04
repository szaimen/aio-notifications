# Docker CLI is a requirement
FROM docker:29.2.1-cli AS docker

# The actual base image
FROM alpine:3.23.3

# hadolint ignore=DL3002
USER root

COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker

# hadolint ignore=DL3018
RUN set -ex; \
    apk upgrade --no-cache -a; \
    apk add --no-cache tzdata bash netcat-openbsd

COPY --chmod=775 start.sh /start.sh
COPY --chmod=775 notify.sh /notify.sh

ENTRYPOINT ["/start.sh"]

# Needed for Nextcloud AIO so that image cleanup can work. 
# Unfortunately, this needs to be set in the Dockerfile in order to work.
LABEL org.label-schema.vendor="Nextcloud"
