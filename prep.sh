#!/bin/bash
apt-get update
apt-get install terminator
apt-get install x11vnc
echo "what is the name of the op?"
read opname
dirname=/cline_$(date +%F)-$opname
mkdir /$dirname
cd /tmp
git clone git://github.com/dfclin073/tten.git/
cp /tmp/tten/* /$dirname
cd /$dirname




echo "use this to connect to vnc server: vinagre 10.50.25.# 5900"
xterm -hold -e x11vnc -o vnclog&
terminator -T opnotes --working-directory /root/Downloads
terminator -T OPS --working-directory /root/Downloads
