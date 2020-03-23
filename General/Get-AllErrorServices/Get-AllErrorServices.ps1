<#
.Synopsis
   Gathers all services that are set to automatic but haven't started
.DESCRIPTION
   Connects to AD server and gathers all servers, confirms that they don't 
   have any services that didn't start due to errors.
   Checks if any services set to "Automatic" didn't start
.EXAMPLE
   Get-AllErrorServices
#>
function Get-AllErrorServices {
    [CmdletBinding()]
    param ()
    
    begin {
        if (!($UserCredential)) {
            Load-Variables
        }
    }
    
    process {
        Invoke-Command -ComputerName $DC1 -Credential $UserCredential -ScriptBlock {
            Import-Module ActiveDirectory
            $Computers = Get-ADComputer -Filter { OperatingSystem -like "Windows Server*" } -Properties cn | Where-Object { $_.enabled }
            foreach ($computer in $computers) {
                if (Test-Connection -ComputerName $Computer.Name -Count 3 -Quiet) {
                    Write-Host "The following services on $($Computer.Name) are meant to be running but are not"
                    Get-WmiObject win32_service -computer $Computer -ErrorAction SilentlyContinue -Filter { State != 'Running' and StartMode = 'Auto' } |
                    ForEach-Object { Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\$($_.Name)" | 
                        Where-Object { $_.Start -EQ 2 -and $_.DelayedAutoStart -NE 1 } } |
                    Select-Object -Property @{label = 'ServiceName'; expression = { $_.PSChildName } }
                }
                else {
                    "$computer.Name is unreachable"
                }
            
            }
        }
    }

}