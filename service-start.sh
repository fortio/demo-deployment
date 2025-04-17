#! /bin/sh
set -x
pkill fortio
pkill proxy
pkill h2life
PATH=$HOME/go/bin:$PATH
fortio server -http-port disabled -tcp-port disabled -udp-port disabled\
   -redirect-port disabled -grpc-port 8079 -P "8443 127.0.0.1:443" >> grpc.log 2>&1 &
h2life >> h2life.log 2>&1 &
cd fortio_data
fortio report -http-port 8080 -redirect-port disabled >> ../report.log 2>&1 &
cd ../fortio_https
proxy -email fortio@fortio.org -h2 -config-dir config/ >> ../proxy.log 2>&1 &
# wait a bit for both to start
sleep 5
# Use the canonical url so tsv cache is generated with the right one
curl -s https://demo.fortio.org/data/index.tsv -o index.tsv
head -2 index.tsv
