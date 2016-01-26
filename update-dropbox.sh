#!/bin/bash

set -u
set -e

apt-get update
apt-get -y upgrade
apt-get clean

cd /usr/local/bin/

rm -f dropbox
wget --no-verbose -O dropbox https://www.dropbox.com/download?dl=packages/dropbox.py
chmod +x dropbox

cd /root/

rm -rf .dropbox-dist/
wget --no-verbose -O dropbox.tgz https://www.dropbox.com/download?plat=lnx.x86_64
tar -xzf dropbox.tgz
rm -f dropbox.tgz
