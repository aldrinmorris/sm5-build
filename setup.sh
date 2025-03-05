#!/bin/bash
if [ $1 == "windows" ]; then
    # Main runtime
    _pkgs=(llvm clang nasm pkg-config)
    # MSY2 dependencies install
    for pkg in ${_pkgs[@]}; do
        # pacman -Syuu --noconfirm mingw-w64-clang-$2-${pkg}
	echo $pkg
    done
    ls /
fi
