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

### 1). Mapping the dir "target_board" to the target board HOST

target_board dir Details:

	

### 2). Config the /etc/passwd

Add line in to to target board file /etc/passwd:

	sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin 


## 3.Testing

     Starting sshd on target board:  # /usr/sbin/sshd
     On host marchine $ ssh root@192.168.1.133

