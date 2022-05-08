#! /bin/bash
set -x
sudo setcap CAP_NET_BIND_SERVICE=+eip `which fortio`
