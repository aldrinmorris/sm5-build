#!/bin/bash -e
_work_dir=$(pwd)
_sources_dir=${_work_dir}/sources

if [ $1 == "windows" ]; then
    if [ $2 == "x86_64" ]; then
        CC=/clang64/bin/clang
	CXX=/clang64/bin/clang++
	AR=/clang64/bin/llvm-ar
	AS=/clang64/bin/llvm-as
	NM=/clang64/bin/llvm-nm
	RANLIB=/clang64/bin/llvm-ranlib
	WINDRES=/clang64/bin/llvm-windres
	LD=/clang64/bin/ld.lld
    elif [ $2 == "aarch64" ]; then
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

chmod +x $CC $CXX $AR $AS $NN $RANLIB $WINDRES $LD

git clone https://git.ffmpeg.org/ffmpeg.git ${_sources_dir}/ffmpeg
pushd ${_sources_dir}/ffmpeg
./configure \
    --arch=$2 \
    --cc=$CC \
    --cxx=$CXX \
    --ar=$AR \
    --as=$AR \
    --nm=$NM \
    --ranlib=$RANLIB \
    --windres=$WINDRES \
    --ld=$LD \
    --enable-cross-compile \
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
    --extra-cflags="-static --static -g0 -O3 -w" \
    --extra-cxxflags="-static --static -g0 -O3 -w" \
    --extra-ldflags="-s -static --static" \
    --prefix=/
make
make install-strip
popd
