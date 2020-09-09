#!/usr/bin/env bash

# Change to script directory
sd=`dirname $0`
cd $sd
# if you ran the script from its own directory you actually just got '.'
# so capture the abs path to wd now
sd=`pwd`
source ./duoopnvpn.sh
wget https://github.com/duosecurity/duo_openvpn/tarball/master
wget https://bootstrap.pypa.io/get-pip.py
mv master master.tar.gz
tar zxf master.tar.gz 
sudo apt-get install build-essential python-dev libssl-dev libffi-dev -y 
sudo  python3 get-pip.py
pip3 install upgrade pip
pip3 install mox
cd  duosecurity-duo_openvpn*
make && sudo make install
sudo sed -i "$ a\ plugin /opt/duo/duo_openvpn.so IKEY SKEY HOSTDUO " /etc/openvpn/server.conf
sudo sed -i "s/IKEY/${IKEY}/" /etc/openvpn/server.conf
sudo sed -i "s/SKEY/${SKEY}/" /etc/openvpn/server.conf
sudo sed -i "s/HOSTDUO/${HOST}/" /etc/openvpn/server.conf
sudo systemctl restart openvpn@server
