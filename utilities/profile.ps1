new-alias np "c:\program files\notepad++\notepad++.exe"
function nnn { netstat /anob }
function ll {get-childitem -force -path $args[0] | sort -property lastwritetime }
Function nn {Get-NetTCPConnection | ft l*address, l*port, r*address, r*port, state, OwningProcess -Auto}
function pp {gwmi win32_process |select ProcessID,ParentProcessID,@{e={$_.GetOwner().User}},commandline | ft -autosize}
function port {test-netconnection -computername $args[0] -port $args[1]}
function which($name) { Get-Command $name | Select-Object Definition }
function rm-rf($item) { Remove-Item $item -Recurse -Force }
function su	{start-process -filepath $args[0] -verb runas}
function grep {sls -pattern $args[0] -path $args[1] -ca | % {"$($_.filename):$($_.line)"}}
#function search {Get-Childitem –Path C:\ -Include $args[0] -file -Recurse -ErrorAction SilentlyContinue}
function prompt {if ($isAdmin) { write-host ( $(Get-Location | Split-Path -Leaf) + " #"  ) -nonewline -foregroundcolor cyan; return " " } else {write-host ($(Get-Location | Split-Path -Leaf) + " $") -nonewline -foregroundcolor green; return " "}}