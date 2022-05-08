#! /bin/sh
set -x
./bind_to_443.sh `which proxy`
nohup fortio server -http-port disabled -tcp-port disabled -udp-port disabled -redirect-port disabled -grpc-port 8079 &
cd fortio_data
nohup fortio report -http-port 8080 -redirect-port disabled &
cd fortio_https
nohup proxy -email fortio@fortio.org -config config/
