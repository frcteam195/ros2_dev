ARG ARCH
FROM guitar24t/ck-ros2-hal:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive
ARG CMAKEVER=3.26.3
ARG ROS_VER=humble
ENV ROS_PYTHON_VERSION=3
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y apt-utils wget software-properties-common x11-apps net-tools iputils-ping vim emacs extra-cmake-modules python3-jinja2 libboost-all-dev \
	python3-pip bash-completion nano parallel mesa-utils curl libgeographic-dev libgtest-dev clang-tidy openjdk-17-jdk libbullet-dev libsdl-dev \
	libsdl-image1.2-dev libsuitesparse-dev libglfw3 libglfw3-dev python-is-python3 python3-flake8-docstrings python3-pytest-cov locales \
	&& rm -rf /var/lib/apt/lists/*

RUN echo 'root:robots' | chpasswd

RUN mkdir /mnt/working
WORKDIR /mnt/working

WORKDIR /tmp

RUN curl -SLO https://github.com/Kitware/CMake/releases/download/v${CMAKEVER}/cmake-${CMAKEVER}.tar.gz \
        && tar -xzvf cmake-${CMAKEVER}.tar.gz \
        && cd cmake-${CMAKEVER} \
        && cmake . -DCMAKE_INSTALL_PREFIX=/usr \
        && make -j4 \
        && make install \
        && apt-mark hold cmake \
        && cd /tmp \
        && rm -Rf /tmp/*

RUN locale-gen en_US en_US.UTF-8 \
	&& update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
	&& LANG=en_US.UTF-8 

ENV LANG=en_US.UTF-8

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update \
	&& apt-get install -y ros-dev-tools \
	&& rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install -U "pytest>=5.3" pytest-repeat pytest-rerunfailures \
	&& python3 -m pip install -U flake8-blind-except flake8-builtins flake8-class-newline flake8-comprehensions flake8-deprecated flake8-import-order flake8-quotes

RUN mkdir -p /ros/ros2_${ROS_VER}/src \
	&& cd /ros/ros2_${ROS_VER} \
	&& vcs import --input https://raw.githubusercontent.com/ros2/ros2/${ROS_VER}/ros2.repos src \
	&& apt-get update \
	&& rosdep init \
        && rosdep update \
        && rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers" \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /ros/ros2_${ROS_VER} \
	&& colcon build -DCMAKE_BUILD_TYPE=Release \
	&& apt-get update \
	&& apt-get install -y rsync \
	&& git clone https://github.com/frcteam195/ros2_system_scripts.git \
	&& cd ros2_system_scripts \
	&& git checkout 2549446 \
	&& mkdir -p /opt/ros/${ROS_VER} \
	&& cp *setup* /opt/ros/${ROS_VER}/ \
	&& cd /ros/ros2_${ROS_VER}/install \
	&& for d in *; do if [[ -d "${d}" && ! -L "${d}" ]]; then echo "Processing ${d}..." ; rsync -a "${d}/" "/opt/ros/${ROS_VER}/" ; echo "Completed processing ${d}!" ; fi ; done \
	&& cd /tmp \
	&& rm -Rf /ros \
	&& rm -rf /var/lib/apt/lists/*

# RUN git clone https://github.com/stiffstream/sobjectizer \
# 	&& cd /tmp/sobjectizer \
# 	&& git checkout 972b5310b7a486dd4d4322ffb46f1c7e15c47ef6 \
# 	&& mkdir cmake_build \
# 	&& cd /tmp/sobjectizer/cmake_build \
# 	&& cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ../dev \
# 	&& cmake --build . --config Release \
# 	&& cmake --build . --config Release --target install \
# 	&& rm -Rf /tmp/*

# WORKDIR /tmp
# RUN git clone https://github.com/frcteam195/CKROSlibzmq.git \
# 	&& cd /tmp/CKROSlibzmq \
# 	&& git checkout 4097855ddaaa65ed7b5e8cb86d143842a594eebd \
# 	&& mkdir cppbuild \
# 	&& cd /tmp/CKROSlibzmq/cppbuild \
# 	&& cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
# 	&& make -j8 \
# 	&& make install \
# 	&& rm -Rf /tmp/*

# WORKDIR /tmp
# RUN git clone https://github.com/frcteam195/CKROSprotobuf.git \
# 	&& cd /tmp/CKROSprotobuf \
# 	&& git checkout 89b14b1d16eba4d44af43256fc45b24a6a348557 \
# 	&& mkdir cppbuild \
# 	&& cd /tmp/CKROSprotobuf/cppbuild \
# 	&& cmake ../cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
# 	&& make -j8 \
# 	&& make install \
# 	&& rm -Rf /tmp/*

# WORKDIR /tmp
# RUN git clone https://github.com/frcteam195/CKROSfmt.git \
# 	&& cd /tmp/CKROSfmt \
# 	&& git checkout d141cdbeb0fb422a3fb7173b285fd38e0d1772dc \
# 	&& mkdir cppbuild \
# 	&& cd /tmp/CKROSfmt/cppbuild \
# 	&& cmake .. \
# 	&& make -j8 \
# 	&& make install \
# 	&& rm -Rf /tmp/*

# WORKDIR /tmp
# RUN git clone https://github.com/frcteam195/CKROSSDL.git \
# 	&& cd /tmp/CKROSSDL \
# 	&& git checkout 2e9821423a237a1206e3c09020778faacfe430be \
# 	&& ./configure \
# 	&& make -j8 \
# 	&& make install \
# 	&& rm -Rf /tmp/*

# RUN git clone https://github.com/GNOME/libxml2.git \
#         && cd libxml2 \
#         && mkdir build \
#         && cd build \
#         && cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
#         && make -j8 \
#         && make install \
#         && cd /tmp \
#         && rm -Rf /tmp/*
