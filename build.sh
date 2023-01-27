#!/bin/bash

set -e

source ./build.conf

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

if [ $OS != "Ubuntu" ]; then
    # TODO: This patch was submitted upstream at:
    # https://salsa.debian.org/live-team/live-build/-/merge_requests/255
    # This can be removed when our Debian container has a version containing this fix
    patch /usr/lib/live/build/binary_grub-efi < live-build-fix-shim-remove.patch

    # TODO: Remove this once debootstrap has a script to build jammy images in our container:
    # https://salsa.debian.org/installer-team/debootstrap/blob/master/debian/changelog
    ln -sfn /usr/share/debootstrap/scripts/gutsy /usr/share/debootstrap/scripts/jammy
fi

lb clean
lb config
lb build

OUTPUT_DIR="out-$ARCH"
mkdir -p "$OUTPUT_DIR"

FILENAME="$(echo $NAME | sed 's/ //g')-$RELEASE_VERSION-$ARCH"
mv "live-image-$ARCH.hybrid.iso" "$OUTPUT_DIR/${FILENAME}.iso"

cd "$OUTPUT_DIR"
md5sum "${FILENAME}.iso" > "${FILENAME}.md5.txt"
sha256sum "${FILENAME}.iso" > "${FILENAME}.sha256.txt"
cd -
