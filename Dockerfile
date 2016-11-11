FROM alpine:3.4
MAINTAINER smizy

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="smizy/php" \
    org.label-schema.url="https://github.com/smizy" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/smizy/docker-nodejs"

RUN set -x \
    && apk update \
    && apk --no-cache add \
        nodejs \
        tini \
    && npm install --global yarn \
    && adduser -D -g '' -s /sbin/nologin -u 1000 docker \
    && mkdir /code 

VOLUME ["/usr/lib/node_modules"]
WORKDIR /code

COPY entrypoint.sh  /usr/local/bin/

ENTRYPOINT ["tini", "--", "entrypoint.sh"]