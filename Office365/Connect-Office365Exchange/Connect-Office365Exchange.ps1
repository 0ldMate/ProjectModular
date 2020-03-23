<#
.Synopsis
   Connects to Microsoft Office365 Exchange.
.DESCRIPTION
   This function is used to connect to the Microsoft Office365 Exchange.
.EXAMPLE
   Connect-Office365Exchange
.EXAMPLE
   Connect-Office365Exchange -Office365UserCredential Nick.Admin@DunderMifflinPaper.com
#>
function Connect-Office365Exchange
{
    [CmdletBinding()]
    Param
    ()

    Process
    {
      if (!(Get-PSSession | Where-Object {$_.computername -eq "aus01b.ps.compliance.protection.outlook.com"})) {
         Load-Variables
         $global:Session365Exchange = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $Office365UserCredential -Authentication  Basic -AllowRedirection -Name "Microsoft Exchange"
      }
    }
}