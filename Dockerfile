FROM ubuntu:20.04

LABEL   maintainer="Pascal Watteel" \
        name="debmirror" \
        version="1.0"

#set env variables
ENV DEBIAN_FRONTEND noninteractive

# Requirements
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y debmirror \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# add config file and directory
ADD mirrorbuild.sh /tmp/mirrorbuild.sh
RUN chmod +x /tmp/mirrorbuild.sh \
    && mv /tmp/mirrorbuild.sh /mirrorbuild.sh \
    && mkdir /data

ENTRYPOINT [ "sh", "./mirrorbuild.sh" ]    
