
FROM ubuntu:20.04

RUN echo Hello
RUN apt-get update
RUN apt-get install -y build-essential git autoconf

RUN git clone https://github.com/hangingman/comskip.git
RUN cd comskip && git submodule init && git submodule update
RUN cd comskip && ./bootstrap

RUN apt-get install -y yasm nasm

RUN git clone https://github.com/mirror/x264.git
RUN cd x264 && git checkout -b has_x264_bit_depth 2451a7282463f68e532f2eee090a70ab139bb3e7
RUN cd x264 && ./configure --enable-shared
RUN cd x264 && make && make install

RUN cd comskip/ffmpeg && ./configure --enable-gpl --enable-version3 --disable-stripping --enable-libx264 --enable-shared
RUN cd comskip/ffmpeg && make && make install
RUN cd comskip && ./configure && make && make install

COPY comskip_wrapper.sh /comskip/misc/
RUN chmod +x comskip/misc/comskip_wrapper.sh

# EOF