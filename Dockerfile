FROM alpine:3.6
MAINTAINER smizy

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="smizy/nodejs" \
    org.label-schema.url="https://github.com/smizy" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/smizy/docker-nodejs"

ENV YARN_HOME  /root/.yarn
ENV PATH       $PATH:${YARN_HOME}/bin:/code/node_modules/.bin

RUN set -x \
    && apk update \
    && apk --no-cache add \
        ca-certificates \
        nodejs \
        tini \
        wget \
    ## yarn
    && wget -q -O - https://yarnpkg.com/latest.tar.gz \
        | tar -xzf - -C /tmp \
    && mv /tmp/dist ${YARN_HOME} \
    && adduser -D -g '' -s /sbin/nologin -u 1000 docker \
    && mkdir /code 

VOLUME ["/usr/lib/node_modules"]
WORKDIR /code

COPY entrypoint.sh  /usr/local/bin/

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]