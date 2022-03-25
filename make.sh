#!/bin/sh

IMGSIZE="10" 

export LFS=/mnt/lfs

echo $LFS
python getSRC.py
echo script isnt stuck, its just making the disk image
touch bin/linuxBootable.img
sudo dd if=/dev/zero of=bin/linuxBootable.img bs=1G count=$IMGSIZE
mkfs -v -t ext4 bin/linuxBootable.img
sudo mkdir -pv $LFS
sudo mount -v -t ext4 bin/linuxBootable.img $LFS
sudo mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/source
wget -O packages.tar http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/lfs-packages-11.1.tar
tar -xf packages.tar -C sources
sudo cp sources/11.1/*.* $LFS/sources
