function Invoke-SituationalAwareness
{
    # Declared the situational awareness section has begun executing
    Write-Output "Beginning Situational awareness check."
    # Pulls the current date & time
    Get-Date
    # Pulls the hostname
    Get-WmiObject win32_OperatingSystem | fl PSComputerName
    # Pulls the IP/MAC address
    Get-WmiObject –Class Win32_NetworkAdapterConfiguration | where-object { $_.IPAddress} | Format-Table
    # Pulls the current process
    $PID
    Get-PSHostProcessInfo
    # Pulls the user context
    ([Security.Principal.WindowsIdentity]::GetCurrent()).Name
    # Determine if running with administrative privileges
    Write-Output "Currently have administrative rights:"; ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] “Administrator”)
}

function Invoke-SecurityCheck
{
    # Declared the security section has begun executing
    Write-Output "Beginning security check."
    # Pulls the list of running processes
    Get-Process
    # Pulls the list of running services
    Get-Service | where-object { $_.Status –eq ‘running’ }
    # Verifies security auditing is enabled
    Get-LogProperties Security | Format-List enabled
    # Displays the audit categories & settings
    auditpol.exe /get /category:*
    # Pulls the 20 most recent entries
    Get-EventLog Security –Newest 20
}

function Invoke-HostInfo
{
    # Declared the Host info section has begun executing
    Write-Output "Beginning Host Info check."
    # Pulls general computer information
    Get-ComputerInfo
    # Pulls hard drive information
    Get-WmiObject –Class Win32_LogicalDisk  -Filter ‘DriveType=3’| Format-Table DeviceID, Size, FreeSpace
    # Pulls processor load
    Get-WmiObject –Class Win32_Processor | Select-Object name, LoadPercentage
    # Pulls memory load
    Get-WmiObject –Class Win32_OperatingSystem | ForEach-Object {“{0:N2}%” –f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize)}
    # Pulls network connections & sockets
    netstat -ano
}

function Invoke-PersistenceCheck
{
    # Declared the persistence section has begun executing
    Write-Output "Beginning persistence check."
    # Pulls the HKLM Run key
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Run
    # Pulls the HKLM RunOnce key
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce
    # Pulls the HKLM Winlogon key
    Get-ItemProperty “HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon”
    # Pulls the HKCU Run key
    Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Run
    # Pulls the HKCU RunOnce key
    Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce
    # Pulls the HKCU Winlogon key
    Get-ItemProperty “HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon”
    # Pulls all at jobs
    at
    # Pulls all scheduled tasks
    schtasks /query  /V /FO list
    # Pulls host startup folder
    Get-ChildItem ‘C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup’
    # Pulls startup folder for each user
    $names = Get-ChildItem C:\Users | where { $_.Name -ne "Public" -and $_.Name -ne "installer" } | select { $_.Name }    
    foreach ($name in $names) { 
        $test = Get-ChildItem ('c:\Users\' + ($name.' $_.Name ') + '\Appdata\Roaming\Microsoft\Windows\Start Menu\Programs\Startup') -ErrorAction SilentlyContinue
        if($test -ne $null)
        {                
            Get-ChildItem ('c:\Users\' + ($name.' $_.Name ') + '\Appdata\Roaming\Microsoft\Windows\Start Menu\Programs\Startup')
        }
    }
    # Pulls all autostart services
    Get-wmiobject win32_service | where-object { $_.StartMode –eq ‘Auto’ } | format-list Name, DisplayName, PathName
}

function Invoke-LogCheck
{
    # Declared the logging check section has begun executing
    Write-Output "Beginning Log check."
    # Pulls every file which has updated in the last hour
    Get-ChildItem –Path C:\ -recurse -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime –ge (Get-Date).AddMinutes(-60) }
}


<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-HostSurvey
{
    [CmdletBinding()]
    Param
    (
        # A switch to run through all functions without breakpoints
        [Switch]$Noninteractive
    )

    Begin
    {
    }
    Process
    {
        # An If statement that determines behvior if the -noninteractive switch was used
        If($noninteractive)
        {
            Invoke-SituationalAwareness
            Invoke-SecurityCheck
            Invoke-HostInfo
            Invoke-PersistenceCheck
            Invoke-LogCheck
        }
        # Else - default behavior, including breakpoints
        else
        {
            # Runs the Situational awareness function
            Invoke-SituationalAwareness
            # A breakpoint to determine if the user wishes to continue
            $bp1 = Read-Host "Do you wish to continue? (Y or N)"
                # If statement to determine if to continue
                if($bp1 -eq 'Y')
                {
                    # Runs the security check function
                    Invoke-SecurityCheck
                    # A breakpoint to determine if the user wishes to continue
                    $bp2 = Read-Host "Do you wish to continue? (Y or N)"
                        # If statement to determine if to continue
                        if($bp2 -eq 'Y')
                        {
                            # Runs the host info function
                            Invoke-HostInfo
                            # A breakpoint to determine if the user wishes to continue
                            $bp3 = Read-Host "Do you wish to continue? (Y or N)"
                                # If statement to determine if to continue
                                if($bp3 -eq 'Y')
                                {
                                    # Runs the persistence function
                                    Invoke-PersistenceCheck
                                    # A breakpoint to determine if the user wishes to continue
                                    $bp4 = Read-Host "Do you wish to continue? (Y or N)"
                                        # If statement to determine if to continue
                                        if($bp4 -eq 'Y')
                                        {
                                            # Runs the log check function
                                            Invoke-LogCheck
                                        }
                                }
                                else
                                {
                                    Write-Output "Survey terminated by operator."
                                }
                        }
                        else
                        {
                            Write-Output "Survey terminated by operator."
                        }
                }
                else
                {
                    Write-Output "Survey terminated by operator."
                }

        }
    }
    End
    {
    }
}

