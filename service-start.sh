#! /bin/sh
set -x
pkill fortio
pkill proxy
PATH=$HOME/go/bin:$PATH
fortio server -http-port disabled -tcp-port disabled -udp-port disabled\
   -redirect-port disabled -grpc-port 8079 -P "8443 127.0.0.1:443" >> grpc.log 2>&1 &
cd fortio_data
fortio report -http-port 8080 -redirect-port disabled >> ../report.log 2>&1 &
cd ../fortio_https
proxy -email fortio@fortio.org -h2 -config config/ >> ../proxy.log 2>&1 &
