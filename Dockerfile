# Docker base image with SBT installed
#
# SBT versions that are cached in this image: [0.13.11]
#
# VERSION 0.1.1

FROM java:openjdk-8-jdk

#
# Configure build tools
#

RUN mkdir -p /usr/local/bin

# Install SBT script (improved SBT script as apposed to the Typesafe DEB version)
RUN apt-get update && \
    apt-get install -y git curl && \
    mkdir -p /usr/local/bin && \
    curl -s https://raw.githubusercontent.com/paulp/sbt-extras/master/sbt > /usr/local/bin/sbt && chmod 0755 /usr/local/bin/sbt

# Set reasonable SBT default options
ENV SBT_OPTS='-Xmx512M -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled'

# Initialize SBT. This causes SBT to download all dependend jars so they are cached in the image.
RUN sbt -sbt-create -sbt-version 0.13.11 clean && \
    rm -rf $HOME/.m2/* $HOME/.ivy2/* && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

