CPU="amd64" # supported options: i686 or amd64

export LFS=/mnt/lfs
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
echo $LFS
cd $LFS/sources

tar binutils-2.38.tar.xz
mkdir -v binutils-2.38/build
cd binutils-2.38/build
../configure --prefix=$LFS/tools \
    --with-sysroot=$LFS \
    --target=$LFS_TGT \
    --disable-nls \
    --disable-werror
make
make install

cd $LFS/sources
tar -xf $LFS/sources/mpfr-4.1.0.tar.xz
mv -v $LFS/sources/mpfr-4.1.0 mpfr
tar -xf $LFS/sources/gmp-6.2.1.tar.xz
mv -v $LFS/sources/gmp-6.2.1 gmp
tar -xf $LFS/sources/mpc-1.2.1.tar.gz
mv -v $LFS/sources/mpc-1.2.1 mpc

if [ "$CPU" = "amd64" ] 
then
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
fi