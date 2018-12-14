date /t && time /t                                                                  
tasklist /V
wmic process get commandline, processid, parentprocessid /format:list
netstat -anob
netsh advfirewall show allprofiles
net share
reg query hklm\software\microsoft\windows\currentversion\run
reg query hklm\software\microsoft\windows\currentversion\runonce
reg query hklm\software
reg query hklm\software\wow6432node
at
schtasks /query /v /fo list
dir /o:d /t:w c:\
dir /o:d /t:w c:\windows\temp
dir /o:d /t:w c:\windows\
dir /o:d /t:w c:\windows\system32
dir /o:d /t:w c:\windows\system32\winevt\logs
Wevtutil qe security /c:25 /rd:true /f:text (whatever has updated from previous dir)
auditpol /get /category:*
ipconfig /all

