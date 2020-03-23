<#
.Synopsis
   Gathers all AD groups and users in those groups.
.DESCRIPTION
   Connects to AD server and gathers all groups and corresponding users in those groups.
   Can be filtered using the ADGroupFilter parameter.
.EXAMPLE
   Get-ADGroups
.EXAMPLE
    Get-ADGroups -ADGroupFilter "Marketing*"
#>
function Get-ADGroups {
    [CmdletBinding()]
    param (
        # AD Group prefix (Marketing* to find Marketing Group 1) can also be * for all
        [String]$ADGroupFilter = "*"
    )
    
    begin {
        if (!($UserCredential)) {
            Load-Variables
        }
        $SessionDC1 = New-PSSession -ComputerName $DC1 -Credential $UserCredential
    }
    
    process {
        Invoke-Command -Session $SessionDC1 -ArgumentList $ADGroupFilter -ScriptBlock{
            param($ADGroupFilter)
            Import-Module -Name ActiveDirectory
            $ADGroupList = Get-ADGroup -Filter * | Where-Object{$_.Name -like "$ADGroupFilter"} | Select-Object Name -ExpandProperty Name | Sort 
            ForEach($ADGroup in $ADGroupList) { 
            Write-Host "Group: "$ADGroup
            Get-ADGroupMember -Identity $ADGroup | Select-Object Name -ExpandProperty Name | Sort 
            Write-Host "" 
            }
            
        }
    }
    
    end {
        Remove-PSSession -Session $SessionDC1
    }
}