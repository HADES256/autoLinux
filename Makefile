# assumes dependincies for linux from scratch-like projects are installed

CC = clang




 
all: getSrc
 

getSrc:

	git -C sources clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable