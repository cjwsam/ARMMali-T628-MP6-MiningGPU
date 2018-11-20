#!/bin/bash
set -e
        apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libgmp-dev libncurses5-dev libtool opencl-headers mali-fbdev -y

	#download required libz
	wget https://github.com/ARM-software/ComputeLibrary/releases/download/v18.03/arm_compute-v18.03-bin-linux.tar.gz

	#extract and move 
	tar -zxf  arm_compute-v18.03-bin-linux.tar.gz
	mv ./arm_compute-v18.03-bin-linux/include/CL/* /usr/include/CL/
	rm -rf ./arm_compute-v18.03-bin-linux

	#download compatible miner 
	git clone https://github.com/hominoids/sgminer-arm

	#config 
	cd sgminer-arm
	git submodule init
	git submodule update
	autoreconf -fi
	CFLAGS="-Os -Wall -march=native -std=gnu99 -mfpu=neon" ./configure --disable-git-version --disable-adl --disable-adl-checks

	#compile with 7 cores as XU4 has 8 
	make -j7
	
	echo " Congrats please run MINE.sh to start mining"






