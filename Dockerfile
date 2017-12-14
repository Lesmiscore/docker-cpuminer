FROM ubuntu AS build
RUN apt-get update && apt-get install -y git libcurl4-openssl-dev gcc-mingw-w64 automake gcc make && \
    git clone https://github.com/macchky/cpuminer.git cpuminer && \
    cd cpuminer && \
    ./autogen.sh && ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer" && make

FROM ubuntu
MAINTAINER nao20010128nao
RUN apt-get update && apt-get install -y libcurl3 && rm -rf /var/lib/apt/lists
COPY --from=build /cpuminer/minerd /usr/bin
ENTRYPOINT ["minerd"]
CMD ["-a","yescrypt","-o","stratum+tcp://mine-zeny.mdpool.me:6969","-u","nao20010128nao.user","-p","password"] 
