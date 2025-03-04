#!/bin/bash
if [ $1 == "windows" ]; then
    _pkgs=(
        llvm clang gcc-compat nasm freetype frei0r-plugins
    )
    for pkg in ${_pkgs}; do
        pacman -Sy mingw-w64-clang-$2-${_pkgs}
    done
fi
