FROM ubuntu:18.04
 
WORKDIR /SOFT/

RUN apt-get update && apt-get upgrade -y 

RUN apt-get update \ 
	&& apt-get install -y \
						apt-transport-https \
 						git \
 						autoconf \
						automake \
						make \
						gcc \
						perl \
						zlib1g-dev \
						libbz2-dev \
						liblzma-dev \
						libcurl4-gnutls-dev \
						libssl-dev \
						libgsl-dev \
						libperl-dev \
						libgsl0-dev \
						libncurses5-dev

RUN apt-get update && apt-get upgrade -y

#LIBDEFLATE
RUN git clone https://github.com/ebiggers/libdeflate /SOFT/libdeflate \
	&& cd libdeflate \
	#&& autoreconf \
	&& make \
	&& make install

#HTSLIB
RUN git clone https://github.com/samtools/htslib /SOFT/htslib \
	&& cd htslib \
	&& autoreconf \
	&& ./configure \
    --enable-plugins \
    --with-plugin-dir=/SOFT/ \
    --with-plugin-path=/SOFT/ \
    --enable-gcs=check \
    --enable-s3=check \
    --with-libdeflate \
    && make \
    && make install

#SAMTOOLS
RUN git clone https://github.com/samtools/samtools /SOFT/samtools \
	&& cd samtools \
	&& autoreconf \
	&& ./configure \
	--with-htslib=/SOFT/htslib \
	--enable-configure-htslib \
    && make \
    && make install 

#BCFTOOLS
RUN git clone https://github.com/samtools/bcftools /SOFT/bcftools \
	&& cd bcftools \
	&& autoreconf \
	&& ./configure \
	--prefix=/SOFT/bcftools \
	--enable-libgsl \
	&& make \
	&& make install

#HTSLIB-PLUGGINS
RUN git clone https://github.com/samtools/htslib-plugins /SOFT/htslib-pluggins \
	&& cd htslib-pluggins \
	#&& autoreconf \
	&& ./configure \
	&& make -f Makefile hfile_irods.c \
	&& make install


CMD bash