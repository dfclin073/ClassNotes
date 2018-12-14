############################################## PowerShell Command Cheat Sheet #############################################################################
############################################## by: Chiron Technology Services #############################################################################
<#
Profile Locations


Current User, Current Host – console

$Home\[My]Documents\WindowsPowerShell\Profile.ps1


Current User, All Hosts   

$Home\[My]Documents\Profile.ps1


All Users, Current Host – console   

$PsHome\Microsoft.PowerShell_profile.ps1


All Users, All Hosts      

$PsHome\Profile.ps1


Current user, Current Host – ISE

$Home\[My]Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1


 All users, Current Host – ISE  

$PsHome\Microsoft.PowerShellISE_profile

#>

## Help 

# Get-help <comdlet/module name>

#Update help
Update-Help

##Alias 

Get-Alias

Set-Alias -Name <name you want> -value <command you want to run> 

##Directory Listings

Get-ChildItem

##Environment Variables

Get-ChildItem Variable:

##Setting Variables

#$<var name> = <cmdlets/modules>

#Available Commands

Get-Command 

#Get-Command -verb <verb you want to search>
#Get-Command -noun <noun you want to search>

##Viewing available Properties/Methods 

# <cmdlet> | Get-Member

##Selecting Specific values

<cmdlet> | Select-Object <values comma separated>

## returning only specifc values

#<cmdlet> | Where-Object {?_.<property>  <delimiter> <vaule to search>}

Get-Process | Where-Object {$_.handles -gt 200}

#*****************************************************
Get-CimInstance Win32_Process | Select-Object processid, parentprocessid, commandline | Format-table -AutoSize
#*****************************************************



##Getting available WMI classes

Get-WmiObject -List

##Getting available CIM classes

Get-CimClass

##Setting Execution Policy

#Set-ExecutionPolicy -ExecutionPolicy <how you want to set it> -scope <user/process/etc>


##Date Time

Get-Date

##System Info 

Get-CimInstance Win32_OperatingSystem | Format-List *

##Processes

#PowerShell way
Get-Process

#CIM Instance

Get-CimInstance -ClassName Win32_Process 

#WMI 

Get-WmiObject -Class Win32_process

##Services

#PowerShell way

Get-Service 

#CIM Instance

Get-CimInstance -ClassName Win32_Service 

#WMI 

Get-WmiObject -Class Win32_Service

##IP Adapter Information

Get-NetIPAddress

Get-NetIPConfiguration

##Routes

Get-NetRoute

##Netstat

Get-NetTCPConnection

netstat -ano

## Ping

Test-Connection -ComputerName www.google.com
Test-NetConnection -ComputerName www.google.com

##Traceroute

Test-NetConnection -ComputerName www.google.com -TraceRoute

##Drivers

#WMI

Get-WmiObject Win32_PnPSignedDriver | Select-Object devicename, driverversion

#CIM Instance

Get-CimInstance Win32_PnPSignedDriver | Select-Object devicename, driverversion

##Firewall

#Firewall Profile
Get-NetFirewallProfile

#Firewall Rules
Get-NetFirewallRule

#******************************************************
# get file time stamps
Get-ChildItem -path C:\Windows | Select-Object name, lastaccesstime, lastwritetime, creationtime | Sort-Object -Property lastwritetime | format-table -AutoSize


# Get ip addresses
Get-ItemProperty 'HKLM:\System\ControlSet001\services\Tcpip\Parameters\Interfaces\*' | Format-List PSChildName,DHCPIPAddress,IPAddress


#Simple directory listing by date
dir /a /od

#Check service within the registry
reg query hklm\system\currentcontrolset\services

#search for a file by name
dir c:\ /s /b | findstr bad.exe


#search for files by date
dir c:\ /s /t:w | findstr "03/20/2014"


