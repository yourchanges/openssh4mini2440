#!/bin/sh

#########################################
###    Author: Yuanjun.Li
###    Email:  yourchanges@gmail.com 
###    Created Time: 2014-10-14
###    Tested OS : Linux Mint 17 Qiana (Ubuntu 14.10)
#########################################

export PATH=/opt/FriendlyARM/toolschain/4.4.3/bin:$PATH
export HOST=arm-unknown-linux-gnueabi

cdir=`pwd`

#clean
rm -rf ssh_*
rm -rf openssh
rm -rf target_board
rm -rf zlib-1.2.8
rm -rf openssl-1.0.1i
rm -rf openssh-6.7p1
mkdir -p openssh
mkdir -p target_board/lib
mkdir -p target_board/usr/sbin
mkdir -p target_board/usr/local/bin
mkdir -p target_board/usr/libexec
mkdir -p target_board/usr/local/etc

#download package
#wget http://www.zlib.net/zlib-1.2.8.tar.gz
#wget http://www.openssl.org/source/openssl-1.0.1i.tar.gz
#wget http://mirror.mcs.anl.gov/openssh/portable/openssh-6.7p1.tar.gz


#unzip
tar xvfz zlib-1.2.8.tar.gz
tar xvfz openssl-1.0.1i.tar.gz
tar xvfz openssh-6.7p1.tar.gz

#set env for building zlib
export CC=arm-linux-gcc
export AR=ar
#build zlib
cd zlib-1.2.8
make clean
./configure --prefix=$cdir/openssh/zlib
make

if [  "XX$?" != "XX0"  ]; then
	echo "zlib make error!"
fi

make install

if [  "XX$?" != "XX0"  ]; then
	echo "zlib make install error!"
fi

cd -



#build openssl
cd openssl-1.0.1i
make clean
./config no-asm shared --prefix=$cdir/openssh/openssl os/compiler:arm-linux-gcc

#set env for building openssl
export CC=arm-linux-gcc
export CFLAG="-fPIC -DOPENSSL_PIC -DOPENSSL_THREADS -D_REENTRANT -DDSO_DLFCN -DHAV E_DLFCN_H -DL_ENDIAN -DTERMIO -O3 -fomit-frame-pointer -Wall"
export DEPFLAG="-DOPENSSL_NO_GMP -DOPENSSL_NO_JPAKE -DOPENSSL_NO_MD2 -DOPENSSL_NO_R    C5 -DOPENSSL_NO_RFC3779 -DOPENSSL_NO_STORE"
export PEX_LIBS=
export EX_LIBS="-ldl"
export EXE_EXT=
export ARFLAGS=
#AR= ar $(ARFLAGS) r
export AR="arm-linux-ar $ARFLAGS r"
#RANLIB=/usr/bin/ranlib
export RANLIB=arm-linux-ranlib
#NM=nm
export NM=arm-linux-nm
export PERL="/usr/bin/perl"
export TAR=tar
export TARFLAGS="--no-recursion"
export MAKEDEPPROG=gcc
export LIBDIR=lib

make
if [  "XX$?" != "XX0"  ]; then
	echo "openssl make error!"
fi
make install
if [  "XX$?" != "XX0"  ]; then
	echo "openssl make install error!"
fi
cd -

#build openssh
cd openssh-6.7p1
make clean
./configure --host=arm-linux --with-libs --with-zlib=$cdir/openssh/zlib --with-ssl-dir=$cdir/openssh/openssl --disable-etc-default-login CC=arm-linux-gcc AR=arm-linux-ar
make
cd -

#generate ssh-key
ssh-keygen -t rsa1 -f ssh_host_key -N ""
ssh-keygen -t rsa -f ssh_host_rsa_key -N ""
ssh-keygen -t dsa -f ssh_host_dsa_key -N ""

#install
sleep 1

cp openssh/zlib/lib/libz.so.1.2.8 target_board/lib/
cp openssh-6.7p1/sshd target_board/usr/sbin/
cp openssh-6.7p1/{scp,sftp,ssh,ssh-add,ssh-agent,ssh-keygen,ssh-keyscan} target_board/usr/local/bin/
cp openssh-6.7p1/{sftp-server,ssh-keysign} target_board/usr/libexec/
cp openssh-6.7p1/{sshd_config,ssh_config} target_board/usr/local/etc/
cp ssh_host_* target_board/usr/local/etc/
