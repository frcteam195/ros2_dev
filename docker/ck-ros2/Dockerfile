ARG ARCH
FROM guitar24t/ck-ros2-lib:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive
ARG ROS_VER=humble

SHELL ["/bin/sh", "-c"]
ARG NOW
WORKDIR /tmp
RUN git clone https://github.com/frcteam195/container_support_files \
	&& sed -i "s/noetic/${ROS_VER}/g" container_support_files/bash.bashrc \
	&& sed -i "s/noetic/${ROS_VER}/g" container_support_files/zsh.zshrc \
	&& cat container_support_files/bash.bashrc > /etc/bash.bashrc \
	&& cat container_support_files/zsh.zshrc > /etc/zsh/zshrc \
	&& rm -Rf /root/.bashrc \
	&& rm -Rf /root/.zshrc \
	&& rm -Rf /root/.profile \
	&& cp -r /root/.ros /mnt/.ros \
	&& cp -r /root/.cache /mnt/.cache \
	&& rm -Rf /tmp/*

WORKDIR /mnt/working
