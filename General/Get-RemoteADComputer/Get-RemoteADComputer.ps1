<#
.Synopsis
   Searches AD for any computers tied to a certain user.
.DESCRIPTION
   Connects to AD server and searches computers descriptions for a match in the name.
   Returns any machines it finds with the description of the user.
.EXAMPLE
   Get-RemoteADComputer -Name "Michael Scott"
#>
function Get-RemoteADComputer {
    [CmdletBinding()]
    param (
        # Name of the person whose computer you want to find
        [String]$Name
    )
    
    begin {
        if (!($UserCredential)) {
            Load-Variables
        }
        $SessionDC1 = New-PSSession -ComputerName $DC1 -Credential $UserCredential
    }
    
    process {
        Invoke-Command -Session $SessionDC1 -ArgumentList $Name -ScriptBlock{
            param($Name)
        Import-Module -Name ActiveDirectory
        Get-ADComputer -Filter "Description -like '$Name'" -Properties Name, Description
        }
    }
    
    end {
        Remove-PSSession -Session $SessionDC1
    }
}