#! /bin/sh
set -x
./bind_to_443.sh `which proxy`
pkill fortio
pkill proxy
nohup fortio server -http-port disabled -tcp-port disabled -udp-port disabled\
   -redirect-port disabled -grpc-port 8079 -P "8443 127.0.0.1:443" >> grpc.log &
cd fortio_data
nohup fortio report -http-port 8080 -redirect-port disabled >> ../report.log &
cd ../fortio_https
nohup proxy -email fortio@fortio.org -h2 -config-dir config/ >> ../proxy.log &
cd ..
sleep 3
tail -f proxy.log
