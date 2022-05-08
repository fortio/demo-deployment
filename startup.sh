#! /bin/sh
set -x
nohup fortio server -http-port disabled -tcp-port disabled -udp-port disabled -redirect-port disabled -grpc-port 8079 &
cd fortio_data
nohup fortio report -http-port 80 -redirect-port disabled &
