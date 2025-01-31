ARG ARCH
FROM guitar24t/ck-ros2-base:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive
ARG ROS_VER=iron

WORKDIR /tmp

RUN apt-get update \
	&& apt-get install -y libi2c-dev libgflags-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:maveonair/helix-editor \
	&& apt-get update \
	&& apt-get install -y clangd bear helix \
	&& python3 -m pip install python-lsp-server \
	&& rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install numpy --upgrade --ignore-installed \
	&& python3 -m pip install opencv-python --upgrade --ignore-installed


RUN git clone https://github.com/zeromq/libzmq.git \
	&& cd /tmp/libzmq \
	&& git checkout 4097855ddaaa65ed7b5e8cb86d143842a594eebd \
	&& mkdir cppbuild \
	&& cd /tmp/libzmq/cppbuild \
	&& cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	&& make -j$(nproc) \
	&& make install \
	&& rm -Rf /tmp/*



WORKDIR /tmp
RUN git clone https://github.com/protocolbuffers/protobuf.git \
        && cd /tmp/protobuf \
        && git checkout f0dc78d7e6e331b8c6bb2d5283e06aa26883ca7c \
        && mkdir cppbuild \
        && cd /tmp/protobuf/cppbuild \
        && cmake ../cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_BUILD_TYPE="Release" \
        && make -j$(nproc) \
        && make install \
        && rm -Rf /tmp/*


#WORKDIR /tmp
#RUN git clone https://github.com/protocolbuffers/protobuf.git \
#       && cd /tmp/protobuf \
#       && git checkout 482156c0f96dd670b9f1ba4f946e66edeb04535f \
#       && cd third_party \
#       && rm -Rf abseil-cpp \
#       && git clone https://github.com/abseil/abseil-cpp.git \
#       && cd abseil-cpp \
#       && git checkout b971ac5250ea8de900eae9f95e06548d14cd95fe \
#       && cd /tmp/protobuf \
#       && mkdir cppbuild \
#       && cd /tmp/protobuf/cppbuild \
#       && cmake ../cmake -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_ABSL_PROVIDER=module -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
#       && make -j$(nproc) \
#       && make install \
#       && rm -Rf /tmp/*


RUN git clone https://github.com/GNOME/libxml2.git \
        && cd libxml2 \
        && mkdir build \
        && cd build \
        && cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
        && make -j$(nproc) \
        && make install \
        && cd /tmp \
        && rm -Rf /tmp/*

SHELL ["/bin/sh", "-c"]
WORKDIR /tmp
RUN git clone https://github.com/nlohmann/json \
	&& cd /tmp/json \
	&& mkdir build \
	&& cd build \
	&& cmake .. \
	&& make -j$(nproc) \
	&& make install \
	&& cd /tmp \
	&& rm -Rf /tmp/*


SHELL ["/bin/bash", "-c"]
RUN mkdir -p /tmp/catkin_ws/src \
	&& cd /tmp/catkin_ws/src \
	&& git clone https://github.com/ros/angles.git angles2 \
	&& cd angles2 \
	&& git checkout ros2 \
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
	&& sudo pip3 install transforms3d \
        && git clone https://github.com/frcteam195/tf_transformations tf_transformations2 \
        && cd tf_transformations2 \
        && cd .. \
	&& git clone https://github.com/frcteam195/robot_localization_ros2.git robot_localization \
	&& cd robot_localization \
	&& git checkout ros2 \
	&& cd /tmp/catkin_ws \
	&& source /opt/ros/${ROS_VER}/setup.bash \
	&& apt-get update \
	&& rosdep install --from-paths src --ignore-src -r -y --skip-keys 'robot_localization angles diagnostic_updater geographic_msgs self_test' \
	&& colcon build --merge-install --install-base /opt/ros/${ROS_VER} \
	&& cd / \
	&& rm -Rf /tmp/* \
	&& rm -rf /var/lib/apt/lists/*


RUN apt-get update \
        && apt-get install -y zsh \
        && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
	&& chmod +x install.sh \
	&& ./install.sh --unattended \
	&& mv /root/.oh-my-zsh /etc/oh-my-zsh \
	&& chmod -R 775 /etc/oh-my-zsh \
        && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/stiffstream/sobjectizer \
	&& cd /tmp/sobjectizer \
	&& git checkout 972b5310b7a486dd4d4322ffb46f1c7e15c47ef6 \
	&& mkdir cmake_build \
	&& cd /tmp/sobjectizer/cmake_build \
	&& cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ../dev \
	&& cmake --build . --config Release \
	&& cmake --build . --config Release --target install \
	&& rm -Rf /tmp/*

WORKDIR /tmp
RUN git clone https://github.com/fmtlib/fmt.git \
	&& cd /tmp/fmt \
	&& git checkout a33701196adfad74917046096bf5a2aa0ab0bb50 \
	&& mkdir cppbuild \
	&& cd /tmp/fmt/cppbuild \
	&& cmake .. \
	&& make -j$(nproc) \
	&& make install \
	&& rm -Rf /tmp/*

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSSDL.git \
	&& cd /tmp/CKROSSDL \
	&& git checkout 2e9821423a237a1206e3c09020778faacfe430be \
	&& ./configure \
	&& make -j$(nproc) \
	&& make install \
	&& rm -Rf /tmp/*
