function get-mando {
write-host ""
write-host ""
get-date
write-host ""
write-host ""
write-host "############ PROCESS LIST ###########" -foregroundcolor "DarkYellow"
#gwmi win32_process | select-object processid, parentprocessid, commandline
cmd.exe /c tasklist
write-host ""
write-host ""
cmd.exe /c gwmi win32_process | select-object processid, parentprocessid, commandline
write-host ""


write-host "############ NETWORK INFO ###########" -foregroundcolor "DarkYellow"
netstat /anob
write-host ""
write-host ""
ipconfig /all
write-host ""

write-host "############ WHO IS LOGGED ON ###########" -foregroundcolor "DarkYellow"
query session
write-host ""

write-host "############ FIREWALL SETTINGS ###########" -foregroundcolor "DarkYellow"
netsh advfirewall show allprofiles
write-host ""

write-host "############ LIST SHARES ###########" -foregroundcolor "DarkYellow"
net share
write-host ""

write-host "############ CHECK REGISTRY PERSISTANCE ###########" -foregroundcolor "DarkYellow"
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Run
write-host ""
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Runonce
write-host ""

write-host "############ CHECK INSTALLED SOFTWARE ###########" -foregroundcolor "DarkYellow"
reg query HKLM\Software
write-host ""
reg query HKLM\Software\wow6432node
write-host ""

write-host "############ CHECKING AT & SCHTASKS ###########" -foregroundcolor "DarkYellow"
at
$tasks = schtasks.exe /query /v /fo csv | ConvertFrom-Csv; $tasks | where-object {$_.'Scheduled Task State' -eq "Enabled"} | select-object TaskName, 'Task To Run'
write-host ""

write-host "############ DIRECTORIES ###########" -foregroundcolor "DarkYellow"
cmd.exe /c dir /o:d /t:w c:\ 
cmd.exe /c dir /o:d /t:w C:\Windows\ 
cmd.exe /c dir /o:d /t:w C:\windows\temp 
cmd.exe /c dir /o:d /t:w C:\Windows\system32 
write-host ""

write-host "############ AUDITPOLICY ###########" -foregroundcolor "DarkYellow"
auditpol /get /category:*
write-host ""

write-host "############ CHECK EVNT LOG DIR ###########" -foregroundcolor "DarkYellow"
cmd.exe /c dir /o:d /t:w C:\Windows\system32\winevt\logs
write-host ""

write-host "############ CHECKING LAST 25 LOGS ###########" -foregroundcolor "DarkYellow"
#wevtutil qe security /c:25 /rd:true /f:text
#get-winevent @{logname='application','security','system';starttime=[datetime]::today} | select logname, timecreated, id, message
get-winevent -logname security -maxevents 25
write-host ""
}

function get-bad{
get-childitem -path c:\windows\prefetch

}

function get-exit{

#write-host "############ FILE CHANGES ###########" -foregroundcolor "DarkYellow"
#Get-ChildItem -Path C:\ -recurse -force -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -ge (Get-Date).AddMinutes(-120) }
write-host ""

write-host "############ DIRECTORIES ###########" -foregroundcolor "DarkYellow"
get-childitem -path c:\windows\temp | sort -property lastwritetime
write-host ""
get-childitem -path c:\windows\system32\winevt\logs | sort -property lastwritetime
write-host ""


write-host "############ LOGS ###########" -foregroundcolor "DarkYellow"
#get-winevent @{logname='application','security','system';starttime=[datetime]::today} | select logname, timecreated, id, message
get-winevent -logname security -maxevents 50
write-host ""

write-host "############ PROCESS LIST ###########" -foregroundcolor "DarkYellow"
#gwmi win32_process | select-object processid, parentprocessid, commandline
cmd.exe /c tasklist
write-host ""


write-host "############ NETWORK INFO ###########" -foregroundcolor "DarkYellow"
netstat -anob
}
get-mando
