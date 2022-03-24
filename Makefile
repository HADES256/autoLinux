# assumes dependincies for linux from scratch-like projects are installed
# sudo losetup -d /dev/loop0
IMGSIZE = 10 #in GB's
LOOP = /dev/loop0
CC = gcc
BINDIR = bin
SRCDIR = sources


 
all: getSrc
 

getSrc:
	sudo losetup -d $(LOOP)
	python3 getSRC.py
	sudo dd if=/dev/zero of=bin/linuxBootable.img bs=1G count=$(IMGSIZE)
	sudo losetup $(LOOP) bin/linuxBootable.img
	sudo mkfs -v -t ext4 $(LOOP)
	export LFS=/mnt/lfs
	sudo mkdir -pv $LFS
	sudo mount -v -t ext4 $(LOOP) $LFS
	sudo losetup -d $(LOOP)
	
	