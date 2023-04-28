ARG ARCH
FROM guitar24t/ck-ros2-hal:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive
ARG CMAKEVER=3.26.3
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y apt-utils wget software-properties-common x11-apps net-tools iputils-ping vim emacs extra-cmake-modules python-jinja2 libboost-all-dev python3-pip bash-completion nano parallel mesa-utils curl libgeographic-dev libgtest-dev clang-tidy openjdk-17-jdk libbullet-dev libsdl-dev libsdl-image1.2-dev libsuitesparse-dev libglfw3 libglfw3-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN echo 'root:robots' | chpasswd

RUN mkdir /mnt/working
WORKDIR /mnt/working

# RUN pip3 install -U rosdep && rosdep init && rosdep update && pip3 install -U rosinstall vcstools rospkg

WORKDIR /tmp
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
RUN git clone https://github.com/frcteam195/CKROSlibzmq.git \
	&& cd /tmp/CKROSlibzmq \
	&& git checkout 4097855ddaaa65ed7b5e8cb86d143842a594eebd \
	&& mkdir cppbuild \
	&& cd /tmp/CKROSlibzmq/cppbuild \
	&& cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	&& make -j8 \
	&& make install \
	&& rm -Rf /tmp/*

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSprotobuf.git \
	&& cd /tmp/CKROSprotobuf \
	&& git checkout 89b14b1d16eba4d44af43256fc45b24a6a348557 \
	&& mkdir cppbuild \
	&& cd /tmp/CKROSprotobuf/cppbuild \
	&& cmake ../cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	&& make -j8 \
	&& make install \
	&& rm -Rf /tmp/*

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSfmt.git \
	&& cd /tmp/CKROSfmt \
	&& git checkout d141cdbeb0fb422a3fb7173b285fd38e0d1772dc \
	&& mkdir cppbuild \
	&& cd /tmp/CKROSfmt/cppbuild \
	&& cmake .. \
	&& make -j8 \
	&& make install \
	&& rm -Rf /tmp/*

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSSDL.git \
	&& cd /tmp/CKROSSDL \
	&& git checkout 2e9821423a237a1206e3c09020778faacfe430be \
	&& ./configure \
	&& make -j8 \
	&& make install \
	&& rm -Rf /tmp/*

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKimgui.git \
	&& cd /tmp/CKimgui \
	&& make -j4 \
	&& make install \
	&& cd /tmp \
	&& git clone https://github.com/frcteam195/CKimplot.git \
	&& cd /tmp/CKimplot \
	&& make -j4 \
	&& make install \
	&& rm -Rf /tmp/*

#Example of how to build and install a ROS package from source
# SHELL ["/bin/bash", "-c"]
# RUN mkdir -p /tmp/catkin_ws/src \
# 	&& cd /tmp/catkin_ws/src \
# 	&& git clone https://github.com/rst-tu-dortmund/teb_local_planner.git \
# 	&& cd /tmp/catkin_ws/src/teb_local_planner \
# 	&& git checkout ec5759d0bf982cd2266715bc06a3385309ec3eb1 \
# 	&& cd /tmp/catkin_ws \
# 	&& source /opt/ros/noetic/setup.bash \
# 	&& apt-get update \
# 	&& rosdep install --from-paths src --ignore-src -r -y \
# 	&& catkin_make -j4 -DCMAKE_BUILD_TYPE=Release \
# 	&& catkin_make install -DCMAKE_INSTALL_PREFIX=/opt/ros/noetic -DCMAKE_BUILD_TYPE=Release \
# 	&& rm -Rf /tmp/* \
# 	&& rm -rf /var/lib/apt/lists/*

RUN curl -SLO https://github.com/Kitware/CMake/releases/download/v${CMAKEVER}/cmake-${CMAKEVER}.tar.gz \
        && tar -xzvf cmake-${CMAKEVER}.tar.gz \
        && cd cmake-${CMAKEVER} \
        && cmake . -DCMAKE_INSTALL_PREFIX=/usr \
        && make -j4 \
        && make install \
        && apt-mark hold cmake \
        && cd /tmp \
        && rm -Rf /tmp/*

RUN git clone https://github.com/GNOME/libxml2.git \
        && cd libxml2 \
        && mkdir build \
        && cd build \
        && cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
        && make -j8 \
        && make install \
        && cd /tmp \
        && rm -Rf /tmp/*

RUN apt-get update \
	&& apt-get install -y locales \
	&& locale-gen en_US en_US.UTF-8 \
	&& update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
	&& LANG=en_US.UTF-8 \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null \


