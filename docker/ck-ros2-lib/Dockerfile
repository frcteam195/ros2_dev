ARG ARCH
FROM guitar24t/ck-ros2-base:${ARCH}
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
RUN git clone https://github.com/zeromq/libzmq.git \
	&& cd /tmp/libzmq \
	&& git checkout 4097855ddaaa65ed7b5e8cb86d143842a594eebd \
	&& mkdir cppbuild \
	&& cd /tmp/libzmq/cppbuild \
	&& cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	&& make -j8 \
	&& make install \
	&& rm -Rf /tmp/*

WORKDIR /tmp
RUN git clone https://github.com/protocolbuffers/protobuf.git \
	&& cd /tmp/protobuf \
	&& git checkout 482156c0f96dd670b9f1ba4f946e66edeb04535f \
	&& mkdir cppbuild \
	&& cd /tmp/protobuf/cppbuild \
	&& cmake ../cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	&& make -j8 \
	&& make install \
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
