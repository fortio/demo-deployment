#! /bin/sh
set -x
uname -a
go version
git pull
CGO_ENABLED=0 go install -a -ldflags "-s -w" fortio.org/fortio@latest; fortio version
CGO_ENABLED=0 go install -a -tags no_tailscale -ldflags "-s -w" fortio.org/proxy@latest; proxy version
CGO_ENABLED=0 go install -a -ldflags "-s -w" fortio.org/logc@latest; logc version
CGO_ENABLED=0 go install -a -ldflags "-s -w" github.com/fortio/terminal/life/h2life@latest; h2life version
./bind_to_443.sh `which proxy`
sudo systemctl restart fortio
sudo systemctl status fortio # to see the index.tsv
tail -f proxy.log | logc -logger-force-color
