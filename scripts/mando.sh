#!/bin/bash

export d='\e[39m' #Default
export r='\e[31m' #Red
export g='\e[32m' #Green
export b='\e[34m' #Blue
export y='\e[33m' #Yellow


function get-mando (){

unset HISTFILE HISTFILESIZE HISTSIZE
export LESSHISTFILE=/dev/null
alias ll='ls -latr'

echo ""
date; date -u
echo ""

echo -e $y"##################### PROCESS LIST ####################"$d
ps -elf
echo ""

echo -e $y"##################### NETWORK INFO ####################"$d
netstat -natup || ss -natup
ifconfig || ip a
echo ""

echo -e $y"##################### WHO IS LOGGED ON ####################"$d
w
echo ""

echo -e $y"##################### ARCHITECTURE ####################"$d
uname -a
echo ""

echo -e $y"##################### MOUNTS & DISK USAGE  ####################"$d
df -h
echo ""

echo -e $y"##################### DIR LISTING /  ####################"$d
ls -latr /
echo ""

echo -e $y"##################### DIR LISTING /TMP  ####################"$d
ls -latr /tmp
echo ""

echo -e $y"##################### DIR LISTING PWD  ####################"$d
ls -latr .
echo ""

echo -e $y"##################### DIR LISTING PARENT DIR  ####################"$d
ls -latr ..
echo ""

echo -e $y"##################### DIR LISTING /ROOT  ####################"$d
ls -latr /root
echo ""

echo -e $y"##################### DIR LISTING /VAR/LOG  ####################"$d
ls -latr /var/log
echo ""

echo -e $y"##################### TAIL LOGS  ####################"$d
echo -e $y"messages"$d
tail /var/log/messages
echo -e $y"secure"$d
tail /var/log/secure
echo -e $y"auth.log"$d
tail /var/log/auth.log

echo ""

echo -e $y"##################### CHECKING FILE SYSTEM FOR CHANGES  ####################"$d
find / -type f -mmin -20 | egrep -v '\/sys|\/proc'
echo ""

echo -e $y"##################### LOOKING FOR HISTORY  ####################"$d
cat /root/.bash_history
cat /home/*/.bash_history
echo ""

echo -e $y"##################### LOOKING FOR VIM HISTORY  ####################"$d
cat /root/.viminfo
cat /home/*/.viminfo
echo ""

echo -e $r"##################### CHECKING FOR PROCESS ACCOUNTING  ####################"
ls -latr /var/*/*acct*
echo -e ""$d

return 0
}

function get-survey() {
echo ""
echo -e $y"##################### CHECK SYSLOG  ####################"$d
cat /etc/*syslog*
echo ""
echo -e $y"##################### SHOW KERNEL MODS  ####################"$d
lsmod

echo ""
echo -e $y"##################### DISTRO INFO  ####################"$d
cat /etc/*release*

echo ""
echo -e $y"##################### CPU INFO  ####################"$d
cat /proc/cpuinfo

echo ""
echo -e $y"##################### SERVICES INFO  ####################"$d
systemctl status --no-pager || service --status-all

echo ""
echo -e $y"##################### CRON INFO  ####################"$d
for user in $(cat /etc/passwd | egrep '/bin/sh|/bin/bash' | cut -d \: -f1); do crontab -u $user -l; done
cat /etc/crontab
ls -la /etc/cron.*

echo ""
echo -e $y"##################### ARP & ROUTE  ####################"$d
ip nei || arp -vn
route -n

echo ""
echo -e $y"##################### RC.LOCAL  ####################"$d
cat /etc/rc.local

echo ""
echo -e $y"##################### MOUNT  ####################"$d
mount

echo ""
echo -e $y"##################### IPTABLES  ####################"$d
if [[ $(lsmod | grep -i table) ]]; then eval "iptables -L"; else echo "No IPTables"; fi
echo ""

echo -e $y"##################### LOOKING FOR SSH KEYS  ####################"$d
ls -latr /root/.ssh
ls -latr /home/*/.ssh
echo ""
echo ""
echo -e $r"##################### COPY ALL SURVEY OUTPUT!!!  ####################"$d
echo ""
echo ""
return 0
}



function get-exit (){
echo ""
echo -e $y"##################### PROCESS LISTING  ####################"$d
ps -elf

echo ""
echo -e $y"##################### NETSTAT  ####################"$d
netstat -lptn

echo ""
echo -e $y"##################### CHECKING FILE SYSTEM FOR CHANGES  ####################"$d
find / -type f -mmin -120 | egrep -v '\/sys|\/proc' 2>/dev/null
echo -e $r"find / -type f -mmin -360 | egrep -v '\/sys|\/proc' 2>/dev/null"$d

echo ""
echo -e $y"##################### DIR /DEV/SHM  ####################"$d
ls -latr /dev/shm

echo ""
echo -e $y"##################### DIR LISTING OF /TMP  ####################"$d
ls -latr /tmp

echo ""
echo -e $y"##################### DIR LISTING OF /VAR/LOG/AUDIT  ####################"$d
ls -latr /var/log/audit

echo ""
echo -e $y"##################### DIR LISTING OF /VAR/LOG  ####################"$d
ls -latr /var/log
echo ""
echo -e $y"##################### TAIL LOGS  ####################"$d
echo -e $y"messages"$d
tail /var/log/messages
echo -e $y"secure"$d
tail /var/log/secure
echo -e $y"auth.log"$d
tail /var/log/auth.log


return 0
}

function get-bad(){
echo ""
echo -e $y"#####Checking for backdoor#####"
ps -elf | egrep -e '-l' -e 'nc' -e '-p'
echo -e $d""

echo ""
echo -e $y"#####CHECKING FOR ODD PROCESSES #####"
ps -elf | egrep -e '*kdump*'
echo -e $d""

echo ""
echo -e $y"#####Checking for PSPs#####"
ls -latr /*ossec
ls -latr /etc/tripwire
ls -latr /var/log/clam*
echo -e $d""

echo ""
echo -e $y"######Checking for RootKits#####"

ldd /bin/ls
echo -e $d ""

echo -e $y"##################### LOOKING FOR PROFILE TRICKS  ####################"$d
cat /root/.bashrc
echo ""
echo ""
echo ""

cat /root/.*profile
echo ""

echo -e $y"##################### LOOKING FOR USERS HOME DIR  ####################"$d
ls -latr /home/*
echo ""

return 0
}

#Dont use, no workie
function get-clean (){
echo "Im broke"
	if [ $# -lt 2 ]; then
echo -e $r"Log cleaning requires at least 2 argument 1. strings to clean, 2. logfile to clean 3. ref file"$d
echo -e $r"usage: get-clean <string> <logfile> [ref file]"$d
else
egrep -v $string /var/log/$logfile > .new
cat .new > /var/log/$logfile
tail -1 /var/log/$logfile
# test if $3 is int or string if [ $# 
touch -r /var/log/$ref /var/log/$logfile
rm -f .new
fi
#needs work
#wc -l /var/log/$logfile
#head -[count -badlogs] /var/log/auth.log > .new
#touch -t yymmddhhmm /var/log/auth.log
#rm -f .new
return 0
}

function port-scan(){
 if [ $# -ne 1 ]; then
echo -e $r"port-scan requires a single argument, the ip of the target "$d
echo -e $r"usage: port-scan 192.168.1.55"$d
else
nc -vzn -w 1 -i 1 $1 445 23 21 22 3389 5900 5985 5986
fi
return 0
}


function ping-sweep(){
if [ $# -ne 1 ]; then
echo -e $r"ping-sweep requires a single argument of the first 3 octets of a /24 network"$d
echo -e $r"usage: ping-sweep 192.168.1"$d
else
for i in `seq 1 254`; do ping -c 1 -W 1 $1.$i | tr \\n ' ' | awk '/1 received/ {print $2}'; done
fi
return 0
}

function redirect-iptables() {
if [ $# -ne 3 ]; then
echo -e $r"Redirection requires three args preNAT PORT Destination IP and post NAT destination PORT"$d
echo -e $r"usage: redirect-iptables <PreNATPort> <dst ip> <PostNATPORT"$d
else
rule1=$1
rule2=$2
rule3=$3
sysctl net.ipv4.ip_forward=1
iptables -t nat -A PREROUTING -p tcp --dport $rule1 -j DNAT --to-destination $rule2:$rule3
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -L
fi
return 0
}

function clean-iptables(){
iptables -t nat -D PREROUTING -p tcp --dport $rule1 -j DNAT --to-destination $rule2:$rule3
iptables -t nat -L
return 0
}

function get-help(){
echo ""
echo -e $b"get-mando 		Runs manditory commands"
echo "get-survey 		Runs a more detailed set of commands"
echo "get-exit 		Runs commands before exiting the session"
echo "get-bad			Checks for a few known PSP and Malware"
echo "port-scan                Scans a single target for commen C2 ports"
echo "ping-sweep 		Conducts a ping sweep of a given /24 network"
echo "redirect-iptables 	Uses iptables to redirect a port on the box to a new host"
echo "clean-iptables 		Removes iptables redirection rule"
echo -e $d "" 
return 0
}
