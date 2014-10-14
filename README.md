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

##1 Build

	$ git clone https://github.com/yourchanges/openssh4mini2440
	$ cd openssh4mini2440
	$ sh build.sh


##2.Install

### 1). Mapping the dir "target_board" to the target board HOST

target_board dir Details:

	target_board/
	├── lib/
	│   └── libz.so.1.2.8
	└── usr/
		├── libexec/
		│   ├── sftp-server
		│   └── ssh-keysign
		├── local/
		│   ├── bin/
		│   │   ├── scp
		│   │   ├── sftp
		│   │   ├── ssh
		│   │   ├── ssh-add
		│   │   ├── ssh-agent
		│   │   ├── ssh-keygen
		│   │   └── ssh-keyscan
		│   └── etc/
		│       ├── ssh_config
		│       ├── sshd_config
		│       ├── ssh_host_dsa_key
		│       ├── ssh_host_dsa_key.pub
		│       ├── ssh_host_key
		│       ├── ssh_host_key.pub
		│       ├── ssh_host_rsa_key
		│       └── ssh_host_rsa_key.pub
		└── sbin/
			└── sshd

	

### 2). Config

Execute the command on target board shell:

	ln -s /lib/libz.so.1.2.8  /lib/libz.so.1

Add line in to to target board file /etc/passwd:

	sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin 


## 3.Testing

     Starting sshd on target board:  # /usr/sbin/sshd
     On host marchine $ ssh root@192.168.1.133

