#!/usr/bin/python
ip=raw_input ("What ip would you like to scan? : ")                                                                                                                                                                

#commands = ["ping -c1 ", "traceroute -n ", "nc -vn ", "nc -vn 23"] 
#commands[1] = commands[1] + (ip)
#print (commands[1])
#for each_cmd in commands:
#        print(each_cmd) (ip)

print ('')
print 'tcpdump -nnvX -s 0 host',(ip)
print ('')
print 'ping -c1' ,(ip)
print ('')
print 'traceroute -n -T -p 80' ,(ip)
print ('')                                                                                                                                                                                                         
print 'telnet' ,(ip), '23'
print ('')                                                                                                                                                                                                         
print 'telnet' ,(ip), '22'
print ('') 
print 'telnet' ,(ip), '5985'
print ('')
print 'telnet', (ip), '80'
print 'GET / http/1.0'
print ('')
print 'wget https://'+(ip), '--user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" -O - -o /dev/null --no-check-certificate'
print ('')
print 'smbclient -L //'+(ip), '-p 445'
print ('')
print 'snmpwalk -c public -v1 '+ (ip)
print ('')
print 'nmap --script smb-os-discovery.nse -p445',(ip)
print ('')
print 'rpcinfo -p', (ip)
print ('')
print 'nmap -n -Pn -sS', (ip), '--top-ports 25'
print ('')
print 'ls /usr/share/nmap/scripts/* | grep ftp'
