#!/bin/bash
#f=/root/projects/$(date +%d%m%y)
if [ ! -d $f ]; then
 mkdir $f
fi
cd "$f"

xterm -e tcpdump -nnvX -s 0 port not 3389 &
terminator --working-directory="$f" -e 'script termscreen.$$' -T Scripted --geometry=1400x800+10+10
terminator --working-directory="$f" -e 'vim opnotes.txt' -T opnotes --geometry=1400x800-10+10

