FROM ubuntu:18.04
 
WORKDIR /SOFT/

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get upgrade -y 
RUN apt-get install apt-transport-https -y
RUN apt-get install apt-utils -y
RUN apt-get install wget -y
RUN apt-get install libncurses5-dev -y
RUN apt-get install build-essential -y
RUN apt-get install zlib1g-dev -y
RUN apt-get install libbz2-dev -y
RUN apt-get install liblzma-dev -y
RUN apt-get update -y
RUN apt-get upgrade -y 

RUN wget -O samtools-1.10.tar.bz2  https://sourceforge.net/projects/samtools/files/latest/download \
			&& tar -xjvf samtools-1.10.tar.bz2 \
			&& cd samtools-1.10 \
			&& ./configure --prefix=/SOFT/ \
			&& make \
			&& make install
 
CMD bash