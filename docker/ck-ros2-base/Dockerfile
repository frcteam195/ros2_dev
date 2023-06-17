ARG ARCH
FROM guitar24t/ck-ros2-hal:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive
ARG CMAKEVER=3.26.3
ARG ROS_VER=iron
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
	&& colcon build --merge-install --install-base /opt/ros/${ROS_VER} \
	&& rm -Rf /ros
