#! /bin/sh
set -x
CGO_ENABLED=0 go install -a -ldflags "-s -w" fortio.org/fortio@latest
CGO_ENABLED=0 go install -a -ldflags "-s -w" fortio.org/proxy@latest
./bind_to_443.sh `which proxy`
sudo systemctl restart fortio
tail -f proxy.log
