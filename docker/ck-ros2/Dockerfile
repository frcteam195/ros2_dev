ARG ARCH
FROM guitar24t/ck-ros2-lib:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive
ARG ROS_VER=humble

SHELL ["/bin/sh", "-c"]
WORKDIR /tmp
RUN git clone https://github.com/nlohmann/json \
	&& cd /tmp/json \
	&& mkdir build \
	&& cd build \
	&& cmake .. \
	&& make -j4 \
	&& make install \
	&& cd /tmp \
	&& rm -Rf /tmp/*

SHELL ["/bin/bash", "-c"]
RUN mkdir -p /tmp/catkin_ws/src \
	&& cd /tmp/catkin_ws/src \
	&& git clone https://github.com/ros/angles.git angles2 \
	&& cd angles2 \
	&& git checkout ${ROS_VER}-devel \
	&& cd .. \
	&& mv angles2/angles ./ \
	&& rm -Rf angles2 \
	&& git clone https://github.com/ros/diagnostics diagnostics2 \
	&& cd diagnostics2 \
	&& git checkout ros2 \
	&& cd .. \
	&& mv diagnostics2/diagnostic* ./ \
	&& rm -Rf diagnostics2 \
	&& git clone https://github.com/ros-geographic-info/geographic_info.git geographic_info2 \
	&& cd geographic_info2 \
	&& git checkout ros2 \
	&& cd .. \
	&& mv geographic_info2/geo* ./ \
	&& rm -Rf geographic_info2 \
	&& git clone https://github.com/frcteam195/robot_localization_ros2.git robot_localization \
	&& cd robot_localization \
	&& git checkout ${ROS_VER}-devel \
	&& cd /tmp/catkin_ws \
	&& source /opt/ros/${ROS_VER}/setup.bash \
	&& apt-get update \
	&& rosdep install --from-paths src --ignore-src -r -y --skip-keys 'robot_localization angles diagnostic_updater geographic_msgs' \
	&& colcon build \
	&& cd install \
	&& && for d in *; do if [[ -d "${d}" && ! -L "${d}" ]]; then echo "Processing ${d}..." ; rsync -a "${d}/" "/opt/ros/${ROS_VER}/" ; echo "Completed processing ${d}!" ; fi ; done \
	&& cd / \
	&& rm -Rf /tmp/* \
	&& rm -rf /var/lib/apt/lists/*


# RUN apt-get update \
#         && apt-get install -y zsh \
#         && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
# 	&& chmod +x install.sh \
# 	&& ./install.sh --unattended \
# 	&& mv /root/.oh-my-zsh /etc/oh-my-zsh \
# 	&& chmod -R 775 /etc/oh-my-zsh \
#         && rm -rf /var/lib/apt/lists/*

	
# RUN apt-get update \
# 	&& apt-get install -y libi2c-dev libgflags-dev \
# 	&& rm -rf /var/lib/apt/lists/*

# RUN pip install numpy --upgrade --ignore-installed \
# 	&& pip install opencv-python --upgrade --ignore-installed


# RUN apt-get update \
#         && apt-get install -y build-essential cmake curl git clang libclang-dev libfontconfig-dev libfreetype-dev libglib2.0-dev libgl-dev libgl1-mesa-dev libice-dev libsm-dev libssl-dev libx11-dev libx11-xcb-dev libxcb1-dev libxcb-glx0-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-xinput-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-sync-dev libxcb-util-dev libxcb-xfixes0-dev libxcb-xinerama0-dev libxcb-xinput-dev libxcb-xkb-dev libxext-dev libxfixes-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev libxrender-dev ninja-build \
#         && rm -rf /var/lib/apt/lists/*

# RUN curl -O -L https://download.qt.io/archive/qt/6.4/6.4.0/single/qt-everywhere-src-6.4.0.tar.xz \
# 	&& tar -xf qt-everywhere-src-6.4.0.tar.xz \
# 	&& cd qt-everywhere-src-6.4.0/ \
# 	&& mkdir qt6-build \
# 	&& cd qt6-build/ \
# 	&& ../configure \
# 	&& cmake --build . --parallel 4 \
# 	&& cmake --install . \
# 	&& cd /tmp \
# 	&& rm -Rf /tmp/*


# RUN python3 -m pip install --upgrade pip setuptools wheel \
# 	&& git clone https://code.qt.io/pyside/pyside-setup \
# 	&& cd pyside-setup \
# 	&& git checkout 6.4 \
# 	&& sed -i 's/pyinstaller==3.6/pyinstaller/g' requirements.txt \
# 	&& python3 -m pip install -r requirements.txt \
# 	&& python3 setup.py build --qtpaths=/usr/local/Qt-6.4.0/bin/qtpaths --ignore-git --parallel 4 --standalone \
# 	&& python3 setup.py install --qtpaths=/usr/local/Qt-6.4.0/bin/qtpaths --ignore-git --parallel 4 --standalone --reuse-build \
# 	&& cd /tmp \
# 	&& rm -Rf /tmp/*


# RUN add-apt-repository ppa:maveonair/helix-editor \
# 	&& apt-get update \
# 	&& apt-get install -y clangd bear helix \
# 	&& python3 -m pip install python-lsp-server \
# 	&& rm -rf /var/lib/apt/lists/*


SHELL ["/bin/sh", "-c"]
ARG NOW
WORKDIR /tmp
RUN git clone https://github.com/frcteam195/container_support_files \
	&& sed -i 's/noetic/${ROS_VER}/g' container_support_files/bash.bashrc \
	&& sed -i 's/noetic/${ROS_VER}/g' container_support_files/zsh.zshrc \
	&& cat container_support_files/bash.bashrc > /etc/bash.bashrc \
	&& cat container_support_files/zsh.zshrc > /etc/zsh/zshrc \
	&& rm -Rf /root/.bashrc \
	&& rm -Rf /root/.zshrc \
	&& rm -Rf /root/.profile \
	&& cp -r /root/.ros /mnt/.ros \
	&& cp -r /root/.cache /mnt/.cache \
	&& rm -Rf /tmp/*


WORKDIR /mnt/working
