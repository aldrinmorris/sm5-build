#!/bin/bash -e
_work_dir=$(pwd)
_sources_dir=${_work_dir}/sources
_build_dir=${_work_dir}/build

_ffmpeg_args="$_ffmpeg_args $@"
if [ $1 == "windows" ]; then
    echo "Exporting envs from vcvars"
    git clone https://github.com/nathan818fr/vcvars-bash.git ${_sources_dir}/vcvars-bash
    _ffmpeg_args="--toolchain=msvc"
    if [ $2 == "x86_64" ]; then
	FFMPEG_ARCH=amd64
	eval "$(${_sources_dir}/vcvars-bash/vcvarsall.sh x64)"
    elif [ $2 == "aarch64" ]; then
	FFMPEG_ARCH=arm64
	eval "$(${_sources_dir}/vcvars-bash/vcvarsall.sh x64_arm64)"
    fi
    _ffmpeg_args+=" \
	--cc=clang-cl \
	--cxx=clang-cl \
	`for i in c{,xx}; do echo -ne --extra-${i}flags='"/std:c99 /MT /w" '; done` \
        --arch=${FFMPEG_ARCH} \
	--enable-cross-compile \
	--target-os=win32 \
	--enable-w32threads \
	--enable-bzlib \
	--enable-d3d11va \
	--enable-d3d12va \
	--enable-dxva2"
fi

git clone https://git.ffmpeg.org/ffmpeg.git ${_sources_dir}/ffmpeg
cd ${_sources_dir}/ffmpeg
./configure \
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
    --enable-bzlib \
    --enable-zlib \
    --prefix=/ \
    ${_ffmpeg_args}
make
make DESTDIR=${_build_dir} install
