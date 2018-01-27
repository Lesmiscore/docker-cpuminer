FROM ubuntu AS build
RUN apt-get update && apt-get install -y git libcurl4-openssl-dev gcc-mingw-w64 automake gcc g++ make libssl-dev libgmp3-dev && \
    git clone https://github.com/jayddee/cpuminer-opt.git cpuminer && \
    cd cpuminer && echo 'cpuminer_LDADD += -lcurl' >> Makefile.am && \
    ./autogen.sh && ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer" && make

FROM ubuntu
MAINTAINER nao20010128nao
RUN apt-get update && apt-get install -y libcurl3 libgmp && rm -rf /var/lib/apt/lists
COPY --from=build /cpuminer/cpuminer /usr/bin
ENTRYPOINT ["cpuminer"]
