FROM ubuntu:20.04

LABEL   maintainer="Pascal Watteel" \
        name="debmirror" \
        version="1.0"

#set arg and env variables
ARG DEBIAN_FRONTEND=noninteractive
ENV GNUPGHOME=/mirrorkeyring \
    dm_arch=amd64 \
    dm_section=main,restricted,universe,multiverse \
    dm_release=focal,focal-security,focal-updates \
    dm_server=ae.archive.ubuntu.com \
    dm_inPath=/ubuntu \
    dm_proto=http \
    dm_outPath=/data/Ubuntu

# Requirements
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y   debmirror \
                            gpg \
                            xz-utils \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# add config file and directory
ADD mirrorbuild.sh /tmp/mirrorbuild.sh
RUN chmod +x /tmp/mirrorbuild.sh \
    && mv /tmp/mirrorbuild.sh /mirrorbuild.sh

ENTRYPOINT [ "sh", "./mirrorbuild.sh" ]    
