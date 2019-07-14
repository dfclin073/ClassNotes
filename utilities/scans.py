#!/usr/bin/python
from os import system
import os, fnmatch

class bcolors:
    WARNING = '\033[93m'
    ENDC = '\033[0m'
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def get_ip():
    ip=raw_input ("What ip would you like to scan? : ")
    return ip

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

def win_scan():
    mysocket = get_control_socket()
    ip = get_ip()                                                                                                 
    subnet = ".".join(ip.split('.')[0:-1])

    system('clear')    

    print ('')
    print 'iptables -A OUTPUT -d',(ip), '-j DROP'
    print ('')
    print 'tcpdump -nnvX -s 0 host',(ip)
    print ('')
    print '1..254 | % {ping -n 1 -w 100' ,(subnet) +'.$_ | select-string ttl}; arp -a'
    print ('')
    print 'traceroute -n -T -p 80' ,(ip) 
    print ('')
    print 'nc -nv 2>&1' ,(ip), '23'
    print bcolors.OKGREEN + 'OR' + bcolors.ENDC            
    print 'ssh -S /tmp/'+(mysocket), '-W' ,(ip)+':23 dummy'
    print ('')  
    print 'nc -nv 2>&1' ,(ip), '5985'
    print ('')
    print 'hostname <NewHostName>'
    print 'smbclient -L //'+(ip), '-p 445 -U <domain/user>'
    print ('')
    print 'snmpwalk -c public -v1 '+ (ip)
    print bcolors.OKGREEN + 'OR' + bcolors.ENDC                                                         
    print 'msfconsole -qn -x "auxiliary/scanner/snmp/snmp_enum; set RHOSTS', (ip)+'; run; exit"'
    print ('')
    print 'nmap --script smb-os-discovery.nse -p445',(ip)
    print bcolors.OKBLUE + '#creates an security event log on target box' + bcolors.ENDC
    print bcolors.OKGREEN + 'OR' + bcolors.ENDC             
    print 'msfconsole -qn -x "auxiliary/scanner/smb/smb_version; set RHOSTS', (ip)+'; run; exit"'
    print bcolors.OKBLUE + '#Can trigger IDS' + bcolors.ENDC
    print (' ')
    print 'smbmap -H', (ip), '-u <username> -p <password> -d <domain>'
    print (' ')
    print '/usr/share/doc/python-impacket/examples/rpcdump.py', (ip)
    print (' ')
    print '/usr/share/doc/python-impacket/examples/rdp_check.py <domain/username:\'password\'>@'+(ip)
    print bcolors.OKGREEN + 'OR' + bcolors.ENDC
    print 'msfconsole -qn -x "auxiliary/scanner/rdp/rdp_scanner; set rhosts', (ip)+'; run; exit"' 
    print (' ')
    print 'ls /usr/share/nmap/scripts/* | grep ftp'
    print (' ')

def nix_scan():
    mysocket = get_control_socket()
    ip = get_ip()
    subnet = ".".join(ip.split('.')[0:-1])

    system('clear')

    print ('')
    print 'iptables -A OUTPUT -d',(ip), '-j DROP'
    print ('')
    print 'tcpdump -nnvX -s 0 host',(ip)
    print ('')
    print 'for i in {1..254}; do ttl+=( "$(ping -W1 -c1',(subnet) +'.$i | grep ttl)" ); done; printf \'%s\\n\' "${ttl[@]}" | grep -v \'^$\'; arp -a'
    print ('')
    print 'traceroute -n -T -p 80' ,(ip)
    print ('')
    print 'nc -nv 2>&1' ,(ip), '22'
    print bcolors.OKGREEN + 'OR' + bcolors.ENDC
    print 'ssh -S /tmp/'+(mysocket), '-W' ,(ip)+':22 dummy'
    print 'nc -nv 2>&1', (ip), '80'
    print 'GET / HTTP/1.0'
    print ('')
    print 'wget --header="Host: <foobar.com>" https://'+(ip), '--user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" -O - -o /dev/null --no-check-certificate'
    print ('')
    print 'snmpwalk -c public -v1 '+ (ip) 
    print bcolors.OKGREEN + 'OR' + bcolors.ENDC
    print 'msfconsole -qn -x "auxiliary/scanner/snmp/snmp_enum; set RHOSTS', (ip)+'; run; exit"'
    print ('')
    print 'rpcinfo -p', (ip)
    print ('')
    print 'nmap -n -Pn -sS', (ip), '--top-ports 25'
    print ('')
    print 'msfconsole -qn -x "auxiliary/scanner/upnp/ssdp_msearch; set RHOSTS', (ip)+'; run; exit"'
    print ('')    
    print 'ls /usr/share/nmap/scripts/* | grep ftp'
    print (' ')

def main():
        PushPullSelect = {
            0: win_scan,
            1: nix_scan
        }
        Selection = 0
        while (Selection != 2):
            print bcolors.WARNING + ("0. Windows") + bcolors.ENDC
            print bcolors.WARNING + ("1. Nix") + bcolors.ENDC
            print bcolors.WARNING + ("2. Quit") + bcolors.ENDC
            Selection = int(input("Select an OS to Scan: "))
            if (Selection >= 0) and (Selection < 2):
                PushPullSelect[Selection]()

main()  
