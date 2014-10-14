#openssh4mini2440

Porting the openssh to mini2440 or mini6410. Provide the helper scripts, doc and binary.

#Requirement: arm toolschain

	$ arm-linux-gcc --version
	.arm-none-linux-gnueabi-gcc (ctng-1.6.1) 4.4.3
	Copyright (C) 2010 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE
	
You can download from http://arm9download.cncncn.com/mini2440/linux/arm-linux-gcc-4.4.3-20100728.tar.gz

#Steps

##1 Build openssh for mini2440 on HOST marchine, cd in this folder, run 

	$ git clone https://github.com/yourchanges/openssh4mini2440
	$ cd openssh4mini2440
	$ sh build.sh


##2.Install the openssh into mini2440 linux

###(1) copy ~/openssh/zlib/lib/libz.so.1.2.8 ~/openssh/openssl/lib/libcrypto.so.1.0.0  ~/openssh/openssl/lib/libssl.so.1.0.0 to target board /lib
       run on target board:
        >ln -s /lib/libz.so.1.2.8  /lib/libz.so.1
        >ln -s /lib/libcrypto.so.1.0.0 /lib/libcrypto.so
        >ln -s /lib/libssl.so.1.0.0 /lib/libssl.so

 ###(2) copy ~/openssh-6.7p1/sshd to target board /usr/sbin
 
       copy ~/openssh-6.7p1/"scp  sftp  ssh  ssh-add  ssh-agent  ssh-keygen  ssh-keyscan"  to target board /usr/local/bin 
       copy ~/openssh-6.7p1/"sftp-server  ssh-keysign" to target board /usr/libexec 
       copy ~/openssh-6.7p1/sshd_config,ssh_config to target board /usr/local/etc/

 ###(3) On target board run：
 
            > mkdir -p /usr/local/etc/
            > mkdir -p /var/run
            > mkdir -p /var/empty/sshd
            > chmod 755 /var/empty

       

 ### copy ~/ssh_* to target board /usr/local/etc/
   
 ### (5) Add line in to to target board file /etc/passwd:
       sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin 


## 3.Testing

     Starting sshd on target board:  # /usr/sbin/sshd
     On host marchine $ ssh root@192.168.1.133

