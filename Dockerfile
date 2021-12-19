FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils wget software-properties-common x11-apps net-tools iputils-ping vim emacs git git-lfs extra-cmake-modules libboost-all-dev python-pip bash-completion nano parallel

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/ros-latest.list
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-key list
RUN apt-get update
RUN apt-get -y install ros-melodic-desktop-full libsdl-dev libsdl-image1.2-dev libsuitesparse-dev ros-melodic-libg2o docker.io qemu

RUN echo 'root:robots' | chpasswd

RUN mkdir /mnt/working
WORKDIR /mnt/working

RUN pip install -U rosdep
RUN rosdep init
RUN rosdep update

RUN pip install -U rosinstall vcstools rospkg

WORKDIR /tmp
RUN mkdir dummy
WORKDIR /tmp/dummy
RUN git init
RUN git lfs install

WORKDIR /tmp
RUN git clone https://github.com/stiffstream/sobjectizer
WORKDIR /tmp/sobjectizer
RUN git checkout 972b5310b7a486dd4d4322ffb46f1c7e15c47ef6
RUN mkdir cmake_build
WORKDIR /tmp/sobjectizer/cmake_build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ../dev
RUN cmake --build . --config Release
RUN cmake --build . --config Release --target install

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSlibzmq.git
WORKDIR /tmp/CKROSlibzmq
RUN git checkout 4097855ddaaa65ed7b5e8cb86d143842a594eebd
RUN mkdir cppbuild
WORKDIR /tmp/CKROSlibzmq/cppbuild
RUN cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON
RUN make -j8
RUN make install

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSprotobuf.git
WORKDIR /tmp/CKROSprotobuf
RUN git checkout 89b14b1d16eba4d44af43256fc45b24a6a348557
RUN mkdir cppbuild
WORKDIR /tmp/CKROSprotobuf/cppbuild
RUN cmake ../cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON
RUN make -j8
RUN make install

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSfmt.git
WORKDIR /tmp/CKROSfmt
RUN git checkout d141cdbeb0fb422a3fb7173b285fd38e0d1772dc
RUN mkdir cppbuild
WORKDIR /tmp/CKROSfmt/cppbuild
RUN cmake ..
RUN make -j8
RUN make install

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKROSSDL.git
WORKDIR /tmp/CKROSSDL
RUN git checkout 2e9821423a237a1206e3c09020778faacfe430be
RUN ./configure
RUN make -j8
RUN make install

RUN apt-get install -y libglfw3 libglfw3-dev

ARG NOW

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKimgui.git
WORKDIR /tmp/CKimgui
RUN make
RUN make install

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/CKimplot.git
WORKDIR /tmp/CKimplot
RUN make    
RUN make install


RUN apt-get install -y ros-melodic-common-msgs ros-melodic-teb-local-planner ros-melodic-robot-localization libgeographic-dev libgtest-dev ros-melodic-turtlebot3-simulations ros-melodic-turtlebot3-gazebo ros-melodic-turtlebot3 clang-tidy

ARG NOW

WORKDIR /tmp
RUN git clone https://github.com/frcteam195/container_support_files
RUN cat container_support_files/bash.bashrc > /etc/bash.bashrc
RUN rm -Rf /root/.bashrc
RUN rm -Rf /root/.profile
RUN cp -r /root/.ros /mnt/.ros
RUN cp -r /root/.cache /mnt/.cache
WORKDIR /mnt/working

RUN rm -Rf /tmp/*
