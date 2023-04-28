FROM ubuntu:22.04
LABEL Name="ck-ros2-hal-amd64"
LABEL Version="22.04"
USER root
ARG DEBIAN_FRONTEND=noninteractive
ARG GITLFSVER=3.3.0
WORKDIR /tmp
RUN apt-get update \
	&& apt-get install -y apt-utils \
	&& apt-get upgrade -y \
	&& apt-get install -y build-essential cmake software-properties-common wget dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev \
		asciidoc xmlto docbook2x install-info \
	&& rm -rf /var/lib/apt/lists/*

RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

RUN apt-get update \
	&& apt-get install -y udev gnupg cmake build-essential apt-utils wget software-properties-common x11-apps net-tools iputils-ping vim emacs extra-cmake-modules libboost-all-dev \
	&& rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev unzip libglfw3-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev sudo -y \
	&& rm -Rf /tmp/* \
	&& rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:git-core/ppa \
	&& apt-get update \
	&& apt-get install -y git git-lfs \
	&& cd /tmp \
	&& mkdir gitlfs \
	&& cd /tmp/gitlfs \
	&& wget https://github.com/git-lfs/git-lfs/releases/download/v${GITLFSVER}/git-lfs-linux-amd64-v${GITLFSVER}.tar.gz \
	&& tar -xzvf git-lfs-linux-amd64-v${GITLFSVER}.tar.gz \
	&& cd git-lfs-${GITLFSVER} \
	&& PREFIX=/usr ./install.sh \
	&& cd /tmp \
	&& apt-mark hold git-lfs \
	&& rm -Rf /tmp/* \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /
