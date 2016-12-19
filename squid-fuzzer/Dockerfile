FROM ubuntu:16.04

RUN apt-get update && apt-get -y dist-upgrade && apt-get -y install build-essential git gcc make wget nmap

WORKDIR /tmp

RUN git clone https://github.com/aoh/radamsa.git && cd radamsa && make && make install


RUN wget http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.23.tar.gz && tar xvzf squid*.tar.gz && rm *.tar.gz
RUN apt-get -y build-dep squid

WORKDIR /tmp/squid-3.5.23

RUN CXXFLAGS="-Wno-error -fsanitize=address -fPIC" CFLAGS="-Wno-error -fsanitize=address -fPIC" ./configure --prefix=/usr --localstatedir=/var --libexecdir=${prefix}/lib/squid --datadir=${prefix}/share/squid --sysconfdir=/etc/squid --with-default-user=proxy --with-logdir=/var/log/squid --with-pidfile=/var/run/squid.pid
RUN CXXFLAGS="-Wno-error -fsanitize=address -fPIC" CFLAGS="-Wno-error -fsanitize=address -fPIC" make
RUN CXXFLAGS="-Wno-error -fsanitize=address -fPIC" CFLAGS="-Wno-error -fsanitize=address -fPIC" make install
RUN mkdir /var/log/squid/; chmod 777 /var/log/squid && touch /var/log/squid/cache.log && chmod 777 /var/log/squid/cache.log && touch /var/log/squid/access.log && chmod 777 /var/log/squid/access.log

ADD fuzzer/* /fuzzer/
RUN mkdir /fuzzer/case1 /fuzzer/case2 /fuzzer/case3
RUN chmod 777 -R /fuzzer

WORKDIR /fuzzer/

ENTRYPOINT ["/fuzzer/entrypoint.sh"]
