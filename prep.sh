#!/bin/bash

export d='\e[39m' #Default
export r='\e[31m' #Red
export g='\e[32m' #Green
export b='\e[34m' #Blue
export y='\e[33m' #Yellow

modprobe dummy
ip link set name eth10 dev dummy0
ip addr add 192.168.100.199/24 brd + dev eth10 label eth10:0

apt-get update
apt-get install terminator -y
apt-get install x11vnc -y
echo "what is the name of the op?"
read opname
dirname=/cline_$(date +%d%b)-$opname
mkdir $dirname
cd /tmp
git clone git://github.com/dfclin073/tten.git/
cp /tmp/tten/survey.sh $dirname/survey.sh
cp /tmp/tten/opnotes-template.txt $dirname/notes_$(date +%F)
cp /tmp/tten/vimrc /root/.vimrc

cd $dirname

ip=ifconfig  | grep '10.50' | cut -d: -f2 | awk '{ print $2}'

echo ""
echo -e $y"use this to connect to vnc server: vinagre $ip 5900"
echo -e $d ""

echo ""
echo -e $y"Make sure to set the Terminal buffer"
echo -e $d ""

echo ""
echo -e $y"script termscreen.$$"
echo -e $d ""

echo ""
echo -e $y"route add -net 10.50.24.0 netmask 255.255.255.0 eth1"
echo -e $d ""

xterm -hold -e x11vnc -o vnclog&   # didnt work
terminator -T opnotes 
terminator -T OPS
#start script



