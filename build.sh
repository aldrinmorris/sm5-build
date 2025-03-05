#!/bin/bash -e
_work_dir=$(pwd)
_sources_dir=${_work_dir}/sources

if [ $1 == "windows" ]; then
    if [ $2 == "x86_64" ]; then
	FFMPEG_ARCH=amd64
    elif [ $2 == "aarch64" ]; then
	FFMPEG_ARCH=arm64
    fi
fi

$CC --version

git clone https://git.ffmpeg.org/ffmpeg.git ${_sources_dir}/ffmpeg
cd ${_sources_dir}/ffmpeg
./configure \
    --toolchain=msvc \
    --arch=$FFMPEG_ARCH \
    --disable-autodetect \
    --disable-avdevice \
    --disable-avfilter \
    --disable-debug \
    --disable-devices \
    --disable-doc \
    --disable-filters \
    --disable-network \
    --disable-postproc \
    --disable-programs \
    --disable-swresample \
    --enable-shared \
    --enable-static \
    --enable-gpl \
    --enable-nonfree \
    --enable-version3 \
    --enable-w32threads \
    --enable-bzlib \
    --enable-d3d11va \
    --enable-d3d12va \
    --enable-dxva2 \
    --enable-zlib \
    --extra-cflags="-static --static -g0 -O2 -w" \
    --extra-cxxflags="-static --static -g0 -O2 -w" \
    --extra-ldflags="-s -static --static" \
    --prefix=/
make
make install-strip
