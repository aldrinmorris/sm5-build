#!/bin/bash
if [ $1 == "windows" ]; then
    # Main runtime
    _pkgs=(git llvm clang nasm pkg-config)
    # MSY2 dependencies install
    for pkg in ${_pkgs}; do
        pacman -Sy --noconfirm mingw-w64-clang-$2-${_pkgs}
    done
fi
