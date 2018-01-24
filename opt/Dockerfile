FROM ubuntu AS build
RUN apt-get update && apt-get install -y git libcurl4-openssl-dev gcc-mingw-w64 automake gcc g++ make libssl-dev libgmp3-dev && \
    git clone https://github.com/jayddee/cpuminer-opt.git cpuminer && \
    cd cpuminer && \
    ./autogen.sh && ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer -lcurl" CXXFLAGS="-lcurl" && make

FROM ubuntu
MAINTAINER nao20010128nao
RUN apt-get update && apt-get install -y libcurl3 libgmp3 && rm -rf /var/lib/apt/lists
COPY --from=build /cpuminer/minerd /usr/bin
ENTRYPOINT ["minerd"]
CMD ["-a","yescrypt","-o","stratum+tcp://koto.poolof.work:3032","-u","k19xSQ7j2F62mYo9UHXihSo6RtRnA2QFZqC","-p","password"]
