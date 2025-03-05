#!/bin/bash -e
_work_dir=$(pwd)
_sources_dir=${_work_dir}/sources

if [ $1 == "windows" ]; then
    if [ $2 == "x86_64" ]; then
	CROSS_COMPILE=/clang64/bin/x86_64-w64-mingw32-
        CC=/clang64/bin/clang
	CXX=/clang64/bin/clang++
	AR=/clang64/bin/llvm-ar
	AS=/clang64/bin/llvm-as
	NM=/clang64/bin/llvm-nm
	RANLIB=/clang64/bin/llvm-ranlib
	WINDRES=/clang64/bin/llvm-windres
	LD=/clang64/bin/ld.lld
    elif [ $2 == "aarch64" ]; then
	CROSS_COMPILE=/clangarm64/bin/aarch64-w64-mingw32-
	CC=/clangarm64/bin/clang
	CXX=/clangarm64/bin/clang++
	AR=/clangarm64/bin/llvm-ar
        AS=/clangarm64/bin/llvm-as
        NM=/clangarm64/bin/llvm-nm
        RANLIB=/clangarm64/bin/llvm-ranlib
	WINDRES=/clangarm64/bin/llvm-windres
        LD=/clangarm64/bin/ld.lld
    fi
fi

git clone https://git.ffmpeg.org/ffmpeg.git ${_sources_dir}/ffmpeg
cd ${_sources_dir}/ffmpeg
./configure \
    --arch=$2 \
    --target-os=mingw32 \
    --cross-prefix=$CROSS_COMPILE
    --cc=$CC \
    --cxx=$CXX \
    --ar=$AR \
    --as=$AR \
    --nm=$NM \
    --ranlib=$RANLIB \
    --windres=$WINDRES \
    --ld=$LD \
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
