#!/usr/bin/env bash

# https://github.com/fatedier/frp/releases

export FRP_VERSION=0.36.2

mkdir binary
cd binary
wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz
tar xfv frp_${FRP_VERSION}_linux_amd64.tar.gz

cd frp_${FRP_VERSION}_linux_amd64
mkdir -p /usr/local/bin/
mkdir -p /usr/local/etc/frp/
cp $PWD/frpc /usr/local/bin/frpc
cp $PWD/frps /usr/local/bin/frps

# vim /usr/local/etc/frp/frpc.ini
# vim /usr/local/etc/frp/frps.ini
# or
# cp $PWD/frps.ini /usr/local/etc/frp/frps.ini

# vim /lib/systemd/system/frpc.service
# vim /lib/systemd/system/frps.service

systemctl start frps

journalctl -u frps.service --since today
