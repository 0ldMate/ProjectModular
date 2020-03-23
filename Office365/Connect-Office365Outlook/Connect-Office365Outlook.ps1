<#
.Synopsis
   Connects to Microsoft Office365 Outlook.
.DESCRIPTION
   This function is used to connect to the Microsoft Office365 Outlook.
.EXAMPLE
   Connect-Office365Outlook
.EXAMPLE
   Connect-Office365Outlook -Office365UserCredential Nick.admin@DunderMifflinPaper.com
#>
function Connect-Office365Outlook
{
    [CmdletBinding()]
    Param
    ()

    Process
    {
      if (!(Get-PSSession | Where-Object {$_.computername -eq "outlook.office365.com"})) {
         Load-Variables
         $global:Session365Outlook =  New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Office365UserCredential -Authentication  Basic -AllowRedirection -Name "Microsoft Outlook"
      }
    }
}