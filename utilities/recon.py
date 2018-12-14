#!/usr/bin/python
from os import system
from random import randint
ip=raw_input ("What IP do you want to scan? : ")
port=str(randint(32768, 65534))
class bcolors:
    WARNING = '\033[93m'
    ENDC = '\033[0m'
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

system('clear')
                                                                                            
print bcolors.WARNING + 'Web Scanning:' + bcolors.ENDC
print 'curl -s http://'+(ip)+'/robots.txt'
print 'nikto -h', (ip)
print 'sqlmap -u "http://'+(ip), '--os-shell'
print 'gobuster -u http://'+(ip), '-w /usr/share/wordlists/dirb/big.txt -t 100'
print 'vega'
print ('')
print bcolors.WARNING + 'Additional recon:' + bcolors.ENDC

print 'dnsrecon -n 8.8.8.8 -r',(ip)+'/31'
print ('')
print 'dnsrecon -n 8.8.8.8 -d domain.com -t axfr'
print ('')
print 'snmpenum -t', (ip)
print ('')
print 'nc -nv', (ip), '25'
print 'VRFY root'
print ('')
