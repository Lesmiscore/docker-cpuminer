FROM ubuntu AS build
RUN apt-get update && apt-get install -y git libcurl4-openssl-dev gcc-mingw-w64 automake gcc make wget unzip && \
    wget -qOcpuminer.zip https://github.com/conan-equal-newone/yenten/releases/download/1.1.0/yenten_minerd_source.zip && \
    unzip cpuminer.zip && mv yenten_miner cpuminer && \
    cd cpuminer && chmod a+x *.sh && touch ChangeLog && \
    ./autogen.sh && ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer -Icompat/jansson/" && make

FROM ubuntu
MAINTAINER nao20010128nao
RUN apt-get update && apt-get install -y libcurl3 && rm -rf /var/lib/apt/lists
COPY --from=build /cpuminer/minerd /usr/bin
ENTRYPOINT ["minerd"]
