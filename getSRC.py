import os



os.system ("git -C sources clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable")

packages = os.path.exists('packages.tar')

if packages == False :
    os.system ("wget -O packages.tar http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/lfs-packages-11.1.tar")
