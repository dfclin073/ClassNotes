#!/usr/bin/python
from random import randint
from os import system

ip=raw_input ("What is the target IP? : ")
port=raw_input ("What is the target Port? : ")
Rip=raw_input ("What is the Redirectors IP? : ")
system('clear')
print ('')
print 'netsh interface portproxy add v4tov4 listenport='+str(randint(32768, 65534)),' listenaddress='+(Rip), 'connectport='+(port),' connectaddress='+(ip)
print ('')
print 'sysctl net.ipv4.ip forward=1'
print 'iptables -t nat -A PREROUTING -p tcp -j DNAT --dport '+str(randint(32768, 65534)),'--to-destination ' +(ip)+':'+(port)
print 'iptables -t nat -A POSTROUTING -j MASQUERADE'
print ('')
print 'cd /tmp'
print 'mknod backpipe q'
print 'nc -v -l -p '+str(randint(32768, 65534)), '0<backpipe | nc '+(ip),(port), '| tee backpipe'
print ('')
print 'ncat -lvnk '+str(randint(32768, 65534)),'-e "/usr/bin/ncat',(ip),(port),'"' 
print ('')
print 'ssh -v -x -fN -M -S /tmp/Rd.s root@'+(Rip), '-o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no"'
print 'ssh -Nf -S /tmp/Rd.s forward user@1.1.1.1 -L 0.0.0.0:'+str(randint(32768, 65534))+':'+(ip)+':'+(port)
print ('')
print 'ssh /tmp/Rd.s user -Nf -D 0.0.0.0:1090'
print 'proxychains /bin/bash'
print 'socat UDP-listen:'+(port)+',reuseaddr,fork UDP:'+(ip)+':'+(port)+ ' &'
print 'socat tcp4-listen:'+(port)+',reuseaddr,fork tcp-4:'+(ip)+':'+(port)+ ' &'
print ('')

print 'portfwd add -l '+str(randint(32768, 65534)),'-p',(port),'-r',(ip)                                 
print ('')

