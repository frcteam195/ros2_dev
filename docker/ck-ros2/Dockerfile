ARG ARCH
FROM guitar24t/ck-ros2-lib:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive
ARG ROS_VER=iron

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

RUN curl -s --compressed -o /usr/share/keyrings/ctr-pubkey.gpg "https://deb.ctr-electronics.com/ctr-pubkey.gpg" \
	&& curl -s --compressed -o /etc/apt/sources.list.d/ctr2023.list "https://deb.ctr-electronics.com/ctr2023.list" \
	&& apt-get update \
	&& apt-get install -y phoenix-pro can-utils -y \
	&& echo 'export LD_LIBRARY_PATH="/usr/lib/phoenix-pro:$LD_LIBRARY_PATH"' >> /etc/bash.bashrc \
	&& echo 'export LD_LIBRARY_PATH="/usr/lib/phoenix-pro:$LD_LIBRARY_PATH"' >> /etc/zsh.zshrc \
	&& rm -Rf /tmp/*

WORKDIR /mnt/working
