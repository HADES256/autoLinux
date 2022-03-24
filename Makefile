# assumes dependincies for linux from scratch-like projects are installed
# sudo losetup -d /dev/loop0
IMGSIZE = 10 #in GB's
LOOP = /dev/loop0
CC = gcc
BINDIR = bin
SRCDIR = sources
LFS = $LFS

 
all: run
 

run:
	sudo chmod u+x make.sh
	./make.sh
	

	

	















