#!/bin/sh
dir
IMGSIZE="10" 

export LFS=/mnt/lfs

python getSRC.py
touch bin/linuxBootable.img
sudo dd if=/dev/zero of=bin/linuxBootable.img bs=1G count=$IMGSIZE

