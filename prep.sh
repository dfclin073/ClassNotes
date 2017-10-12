#!/bin/bash
apt-get update
apt-get install terminator
apt-get install x11vnc
echo "what is the name of the op?"
read dirname
mkdir /cline_$(date +%F)-$dirname

git files


echo "use this to connect to vnc server vinagre 10.50.25.# 5900"
xterm -e x11vnc -o vnclog&

