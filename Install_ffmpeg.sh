#!/bin/bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS."
    exit 1
fi

case "$OS" in
    ubuntu|debian)
        sudo apt update
        sudo apt install -y ffmpeg
        ;;
    fedora)
        sudo dnf install -y ffmpeg
        ;;
    centos)
        sudo yum install -y epel-release
        sudo yum install -y ffmpeg
        ;;
    arch)
        sudo pacman -Sy --noconfirm ffmpeg
        ;;
    opensuse-leap|opensuse-tumbleweed)
        sudo zypper install -y ffmpeg
        ;;
    *)
        echo "Unsupported Linux distribution."
        exit 1
        ;;
esac

ffmpeg -version