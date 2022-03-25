#!/bin/sh

IMGSIZE="10" #in GBS
CPU="amd64" # supported options: i686 or amd64

export LFS=/mnt/lfs
echo $LFS
python getSRC.py
echo script isnt stuck, its just making the disk image
sudo dd if=/dev/zero of=bin/linuxBootable.img bs=1G count=$IMGSIZE
mkfs -v -t ext4 bin/linuxBootable.img
sudo mkdir -pv $LFS
sudo mount -v -t ext4 bin/linuxBootable.img $LFS
sudo mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/sources
tar -xf packages.tar -C sources
sudo cp -R sources/11.1/. $LFS/sources
sudo mkdir -pv $LFS/var
sudo mkdir -pv $LFS/etc
sudo mkdir -pv $LFS/usr/bin
sudo mkdir -pv $LFS/usr/lib
sudo mkdir -pv $LFS/usr/sbin
if [ "$CPU" = "amd64" ] 
then
    sudo mkdir -pv $LFS/lib64
fi
sudo mkdir -pv $LFS/tools
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs
sudo passwd lfs
sudo chown -v lfs $LFS/sources
sudo chown -v lfs $LFS/var
sudo chown -v lfs $LFS/etc
sudo chown -v lfs $LFS/usr
sudo chown -v lfs $LFS/tools
sudo chown -v lfs $LFS/usr
sudo chown -v lfs $LFS/usr/bin
sudo chown -v lfs $LFS/usr/lib
sudo chown -v lfs $LFS/usr/sbin
if [ "$CPU" = "amd64" ] 
then
    sudo chown -v lfs $LFS/lib64
fi
su - lfs
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF