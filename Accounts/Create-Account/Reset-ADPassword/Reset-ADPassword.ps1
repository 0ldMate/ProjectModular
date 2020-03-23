<#
.Synopsis
    2nd step of the Create-Account Script
.DESCRIPTION
    This is the second part of the account creation script. This resets the password of the accounts after they have been set up on a machine.
   Reset passwords of accounts with data from a csv in Active Directory. Gives a spanning license and updates a ticket in Jira. It also emails the manager the user's password.
   It can run through and reset passwords for multiple accounts at a time depending on the data in the csv.
   Options available in this script:
        - Email Enabled
        - JIRA
        - Spanning
        - Random Password
   You must use the csv with this script.
.EXAMPLE
   Reset-ADPassword
#>
function Reset-ADPassword
{
    [CmdletBinding()]
    param(
        $ImportedCSV=((Get-Item -Path $PSScriptroot).Parent.FullName + "\Employee.csv")
    )

    Begin
    {
	
        $Prompt = Read-Host -Prompt "Have you edited the Employee.csv?"
        if ($Prompt -eq "No") {
            notepad.exe $ImportedCSV
            Read-Host -Prompt "Press enter when you've edited it."
        }

        if (!($UserCredential)) {
            Load-Variables
        }

        $SessionDC1 = New-PSSession -ComputerName $DC1 -Credential $UserCredential -Name DC1
        Import-Module -PSSession $SessionDC1 -Name ActiveDirectory
        if ($JiraEnabled -eq "Yes"){
            if(!(Get-JiraSession)) {
                Connect-Jira
            }
        }
        if ($SpanningEnabled -eq "Yes"){
            if(!(Get-Module SpanningO365)){
                Write-host "Spanning Module not loaded, loading module."
                Import-Module $SpanningPath
            }
        }
        $ImportedCSV = Import-Csv $ImportedCSV
    }
    Process
    {
        $ImportedCSV | foreach {
            $Name = $_.Name
            $Firstname = $Name.Split(" ")[0]
            $Surname = $Name.Split(" ")[1]
            $SAMAccountName = $Firstname.Substring(0,1) + $Surname
            $UserPrincipal = "$SAMAccountName" + "$CompanyEmail"
            $Manager = $_.Manager
            $ManagerEmail = $_.ManagerEmail
            
            if ($RandomPasswordEnabled -eq "Yes"){
                $Password = (New-PassPhrase -MinLength 10) + (Get-Random -Maximum 200)
            } else {
                $Password = Read-Host "Input password to be reset to"
            }
            Load-Variables

            Set-ADAccountPassword $SAMAccountName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force)
            Set-ADUser -Identity $SAMAccountName -ChangePasswordAtLogon $true

            if ($EmailEnabled -eq "Yes"){
                Send-EmailMessage -EmailTo $ManagerEmail -EmailBody $EmailAccountCreation -EmailSubject $EmailSubjectAccountCreation
                Write-Host "$Name's password has been reset and emailed to $ManagerEmail and will be reset at logon"
            }

            if ($JiraEnabled -eq "Yes"){
                $TicketNumber = $_.TicketNumber
                $Ticket = "$JiraProject" + "-" + "$TicketNumber"
                Add-JiraIssueComment -Issue "$Ticket" -Comment "$JiraCreationComment2" 
                write-Host "$TicketNumber has been edited with this info" 
            }

            if ($SpanningEnabled -eq "Yes"){
                Import-Module $SpanningPath
                Get-SpanningAuthentication -ApiToken $SpanningAPI -Region $SpanningRegion -AdminEmail $SpanningAdminEmail
                Enable-SpanningUser -UserPrincipalName "$UserPrincipal"
                Write-Host "Spanning has been enabled"
            }
            Write-Host "$Name's account has been created."
        }
    }
    End
    {
        Remove-PSSession -Session $SessionDC1
    }
}