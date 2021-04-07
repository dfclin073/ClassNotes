#!/bin/bash
lhost=$(ifconfig $1 | grep 'inet' | cut -d: -f2 | awk '{print $2}')
echo $lhost
export lhost

