# Base image from (http://phusion.github.io/baseimage-docker)
FROM phusion/baseimage:0.9.20
# Think if we need a version or latest?

# Set image labels
LABEL net.corda.version="0.9.2"
LABEL vendor="R3"
LABEL net.corda.release-date="2017-04-05"
# Do we need more labels?
MAINTAINER Wawrzyniec 'Wawrzek' Niewodniczanski <wawrzek@r3.com>

# Update system
RUN apt-get -y update && apt-get -y upgrade
# Do we want to upgrade apt?

# Install package
RUN apt-get -qqy install ntp

# Install OpenJDK from zulu.org
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
RUN echo "deb http://repos.azulsystems.com/ubuntu stable main" >> /etc/apt/sources.list.d/zulu.list
RUN apt-get -qq update
RUN apt-get -qqy install zulu-8=8.20.0.5

# Cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create /opt/corda directory
RUN mkdir -p /opt/corda/logs
RUN mkdir -p /opt/corda/plugins
RUN ln -s /opt/corda/logs /var/log/corda

# Copy node config
COPY node.conf /opt/corda

# Copy corda jar (for now use local dir rather then remote location)
ADD https://dl.bintray.com/r3/corda/net/corda/corda/0.9.2/corda-0.9.2.jar /opt/corda/corda.jar
#COPY corda.jar /opt/corda/

### Init script for corda
RUN mkdir /etc/service/corda
COPY corda.sh /etc/service/corda/run
RUN chmod +x /etc/service/corda/run

# Expose port for corda (default is 10002)
EXPOSE 10002

# Working directory for Corda
WORKDIR /opt/corda
ENV HOME=/opt/corda

# Start runit
CMD ["/sbin/my_init"]

