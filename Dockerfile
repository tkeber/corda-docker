# Base image from (http://phusion.github.io/baseimage-docker)
FROM phusion/baseimage:0.9.22

# Override default value with 'docker build --build-arg buildtime_corda_version=version'
# example: 'docker build --build-arg buildtime_corda_version=1.0.0 -t corda/node:1.0 .'
ARG buildtime_corda_version=2.0.0
ENV corda_version=${buildtime_corda_version}

MAINTAINER <devops@r3.com>

# Set image labels
LABEL net.corda.version=${corda_version}
LABEL vendor="R3"

# Install OpenJDK from zulu.org and update system
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 && \
    (echo "deb http://repos.azulsystems.com/ubuntu stable main" >> /etc/apt/sources.list.d/zulu.list) && \
    apt-get -qq update && \
    apt-get -y upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get -qqy install zulu-8 ntp --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add user corda
RUN groupadd corda && \
    useradd -c "Corda user" -g corda -m -s /bin/bash corda

# Create /opt/corda directory
RUN mkdir -p /opt/corda/plugins && \
    mkdir -p /opt/corda/logs && \
    mkdir -p /opt/corda/etc && \
    touch /opt/corda/etc/abc

# Copy corda jar
ADD --chown=corda:corda https://dl.bintray.com/r3/corda/net/corda/corda/${corda_version}/corda-${corda_version}.jar /opt/corda/corda.jar
# (for now use local dir rather then remote location)
#COPY corda-${corda_version}.jar /opt/corda/corda.jar

### Init script for corda
RUN mkdir /etc/service/corda
COPY corda-${corda_version}.sh /etc/service/corda/run
RUN chmod +x /etc/service/corda/run

RUN chown -R corda:corda /opt/corda

# Expose port for corda (default is 10002) and RPC
EXPOSE 10002
EXPOSE 10003

# Working directory for Corda
WORKDIR /opt/corda
ENV HOME=/opt/corda

# Start runit
CMD ["/sbin/my_init"]
