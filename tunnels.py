#!/usr/bin/python
from random import randint

ip=raw_input ("What is the target IP? : ")
port=raw_input ("What is the target Port? : ")
Rip=raw_input ("What is the Redirectors IP? : ")

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
print 'socat TCP4:LISTEN:'+str(randint(32768, 65534)),'TCP4:'+(ip)+':'+(port)
print ('')
print 'ssh -N -M -S /tmp/sshT1 root@'+(Rip)
print 'ssh -S /tmp/sshT1 -O forward user@1.1.1.1 -L 0.0.0.0:'+str(randint(32768, 65534))+':'+(ip)+':'+(port)
print ('')
print 'ssh root@'+(ip), '-D 1095'
print ('')
print 'portfwd add -l '+str(randint(32768, 65534)),'-p',(port),'-r',(ip)
print ('')
