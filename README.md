# autoLinux
automated script system to build a custom minimal linux distro


	sudo losetup $(LOOP) bin/linuxBootable.img
	sudo mkfs -v -t ext4 $(LOOP)
	export LFS=/mnt/lfs
	sudo mkdir -pv /mnt/lfs
	sudo mount -v -t ext4 $(LOOP) $LFS
	umount /mnt/lfs
	sudo losetup -d $(LOOP)
	