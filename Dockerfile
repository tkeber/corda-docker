# Base image from (http://phusion.github.io/baseimage-docker)
FROM openjdk:8u151-jre-alpine

# Override default value with 'docker build --build-arg buildtime_corda_version=version'
# example: 'docker build --build-arg buildtime_corda_version=1.0.0 -t corda/node:1.0 .'
ARG buildtime_corda_version=2.0.0

ENV corda_version=${buildtime_corda_version}
MAINTAINER <devops@r3.com>

# Set image labels
LABEL net.corda.version = ${corda_version}
LABEL vendor = "R3"

RUN apk upgrade --update && \
	apk add --update --no-cache bash iputils && \
	rm -rf /var/cache/apk/*

# Add user to run the app
RUN addgroup corda && \
    adduser -G corda -D -s /bin/bash corda

# Create /opt/corda directory
RUN mkdir -p /opt/corda/plugins && \
    mkdir -p /opt/corda/logs

# Copy corda jar
ADD --chown=corda:corda https://dl.bintray.com/r3/corda/net/corda/corda/${corda_version}/corda-${corda_version}.jar /opt/corda/corda.jar

COPY files/run-corda.sh /run-corda.sh
RUN chmod +x /run-corda.sh && sync

RUN chown -R corda:corda /opt/corda

# Expose port for corda (default is 10002) and RPC
EXPOSE 10002
EXPOSE 10003

# Working directory for Corda
WORKDIR /opt/corda
ENV HOME=/opt/corda
USER corda

# Start it
CMD ["/run-corda.sh"]
