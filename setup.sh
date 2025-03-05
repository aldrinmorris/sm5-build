#!/bin/bash
if [ $1 == "windows" ]; then
    # Main runtime
    _pkgs=(harfbuzz)
    # MSY2 dependencies install
    for pkg in ${_pkgs[@]}; do
        echo "Installing mingw-w64-clang-$2-$pkg package"
        pacman -Syuu --noconfirm mingw-w64-clang-$2-$pkg > /dev/null
    done
fi
