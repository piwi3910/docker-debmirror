FROM ubuntu:20.04

LABEL   maintainer="Pascal Watteel" \
        name="debmirror" \
        version="1.0"

#set env variables
ENV DEBIAN_FRONTEND noninteractive \
    GNUPGHOME /mirrorkeyring

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
    && mkdir /data \
    && mkdir ${GNUPGHOME} \
    && gpg --no-default-keyring --keyring ${GNUPGHOME}/trustedkeys.gpg --import /usr/share/keyrings/ubuntu-archive-keyring.gpg

ENTRYPOINT [ "sh", "./mirrorbuild.sh" ]    
