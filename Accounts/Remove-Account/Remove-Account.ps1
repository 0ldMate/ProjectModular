<#
.Synopsis
   Removes accounts with data from a csv
.DESCRIPTION
   Removes accounts with data from a csv in Active Directory and updates a ticket in Jira.
   It can run through and remove multiple accounts at a time depending on the data in the csv.
    Options available in this script:
        - Email Reminder
        - Audit Document
        - Spanning
        - JIRA
        - Download .pst file (depreciated)
   You must use the csv with this script.
.EXAMPLE
   Remove-Account
#>
function Remove-Account {
    [CmdletBinding()]
    param(
        # CSV location
        $ImportedCSV="$PSScriptRoot\Employee.csv"
    )

    Begin {
        $Prompt = Read-Host -Prompt "Have you edited the Employee.csv?"
        if ($Prompt -eq "No") {
            notepad.exe $ImportedCSV
            Read-Host -Prompt "Press enter when you've edited it."
        }
        
        if (!($UserCredential)) {
            Load-Variables
        }
        if (!($Office365UserCredential)) {
            Load-Variables
        }

        $SessionDC1 = New-PSSession -ComputerName $DC1 -Credential $UserCredential -Name DC1
        Connect-Office365Outlook
        Connect-MsolService -Credential $Office365UserCredential
        Import-PSSession $Session365Outlook -CommandName Get-mailbox, set-mailbox, set-mailboxautoreplyconfiguration -AllowClobber
        if ($JiraEnabled -eq "Yes") {
            if (!(Get-JiraSession)) {
                Connect-Jira
            }
        }
        $ImportedCSV = Import-Csv $ImportedCSV
        $TDate = (Get-Date).AddDays(30) | Get-Date -UFormat "%e/%m/%Y"
        $CurrentDate = Get-Date -UFormat "%e/%m/%Y"

    }
    Process {
        $ImportedCSV | foreach {
            $TUser = $_.TUser
            $UserRedirect = $_.UserRedirect
            $Department = $_.Department
            $TLastDay = $_.LastDay
            $Username = $_.Username
            $UsernameEmail = $_.UsernameEmail

            if ($RandomPasswordEnabled -eq "Yes"){
                $Password = (New-PassPhrase -MinLength 20) + (Get-Random -Maximum 200)
            } else {
                $Password = Read-Host "Input password to be reset to"
            }
            Load-Variables

            Write-Host "Connecting to $DC1"
            Invoke-Command -Session $SessionDC1 -ArgumentList $TUser,$Serverfiles,$BackupDestination,$Password -ScriptBlock {

                param($tuser,$Serverfiles,$BackupDestination,$Password)

                # Gathers data about $Tuser
                Import-Module ActiveDirectory
                $TuserObject = get-aduser -Filter 'Name -like $Tuser'
                $TOU = Get-ADObject -filter 'Name -like "Terminated Users"'
                $TUserGroups = Get-ADPrincipalGroupMembership ($TuserObject).ObjectGUID
        
                set-adaccountpassword $TuserObject.ObjectGUID -reset -newpassword (ConvertTo-SecureString -AsPlainText "$Password" -force)
                Write-Host "Password has been changed"
        
                # Moves User to Terminated Users
        
                Move-ADObject ($TuserObject).ObjectGUID -TargetPath ($TOU).objectGUID
                Write-Host "User has been moved to Terminated Users"
        
                # Removes user from all groups except Domain Users
        
                ForEach ($TuserGroup in $TUserGroups) {
                    if ($TUserGroup.name -ne "Domain Users") { Remove-ADGroupMember -Identity $TuserGroup.name -Members $TUserObject.ObjectGUID -Confirm:$False }
                }
                Write-Host "Groups have been removed"
                
                # Moves DC2 Folder to Backup Server (commented out as not needed at the moment)
        
                #Copy-Item $ServerFiles -Destination $BackupDestination -Recurse
                #Write-Host "$Serverfiles folders copied to $BackupDestination"
                #Read-Host -prompt "Check if files are moved to $BackupDestination, confirm deletion of files (Press enter after confirming)"
                #Get-ChildItem $ServerFiles -Recurse | Remove-Item -Force
        
                #check if someone has a computer in AD, if so asks if they want to move the computer to the standard Computer directory
        
                $ADComputerDir = Get-ADObject -filter 'cn -like "Computers"'
                $ADComputerObject = Get-ADComputer -Filter { Description -like $Tuser } | Select-Object -ExpandProperty ObjectGUID
                $ADComputerName = Get-ADComputer -Filter { Description -like $Tuser } | Select-Object -ExpandProperty Name
            
                if ($ADComputerName) {
                    foreach ($ADComputer in $ADComputerObject) {
                            move-adobject $ADComputer -TargetPath $ADComputerDir
                            Write-Host "$ADComputer has been found, moving computer to general directory"
                    }
                }
            }
        
            Write-Host "Setting up email forwarding and AutoReply"

            $RedirectEmail = (Get-Mailbox $UserRedirect).primarySMTPaddress
            Set-Mailbox -Identity "$tuser" -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "$RedirectEmail" 
            Set-Mailbox -Identity "$tuser" -Type Shared
            Write-Host "Account has been converted to a shared mailbox"
            Set-MailboxAutoReplyConfiguration -Identity $tuser -AutoReplyState Enabled -ExternalMessage "$AutoReply" -InternalMessage "$AutoReply"
            
            #remove License
            $365Licenses = Get-MsolAccountSku
            foreach($365License in $365Licenses.accountskuid){
                Set-MsolUserLicense -UserPrincipalName $UsernameEmail -RemoveLicenses $365License
            }
            Write-Host "All Office365 licenses have been removed from the account."

            if ($EmailReminder -eq "Yes"){
            Write-Host "Setting up Outlook reminder to delete account in 30 days"
            $ol = New-Object -ComObject Outlook.Application
            $meeting = $ol.CreateItem('olAppointmentItem')
            $meeting.Subject = "Delete $Tuser Account"
            $meeting.Body = 'Delete Account'
            $meeting.Location = 'Virtual'
            $meeting.ReminderSet = $true
            $meeting.Importance = 1
            $meeting.MeetingStatus = [Microsoft.Office.Interop.Outlook.OlMeetingStatus]::olMeeting
            $meeting.Recipients.Add("$OutlookEmail") | Out-Null
            $meeting.ReminderMinutesBeforeStart = 15
            $meeting.Start = [datetime]::Today.Adddays(30).Addhours(9)
            $meeting.Duration = 30
            $meeting.Send()
            }

            if ($AuditDocument -eq "yes"){
                New-TerminationDocument
                Write-Host "The termination document has been generated."
            }

            if ($JiraEnabled -eq "Yes") {
                $TicketNumber = $_.TicketNumber
                $Ticket = "$JiraProject" + "-" + "$TicketNumber"
                Add-JiraIssueComment -Issue "$Ticket" -Comment "$JiraTerminationComment"  
                Add-JiraIssueWorklog -Issue $Ticket -TimeSpent "00:15" -Comment $JiraTerminationWorkLog -DateStarted (Get-Date)
            }

            if ($SpanningEnabled -eq "Yes"){
                Import-Module $SpanningPath
                Get-SpanningAuthentication -ApiToken $SpanningAPI -Region $SpanningRegion -AdminEmail $SpanningAdminEmail
                Disable-SpanningUser -UserPrincipalName "$UsernameEmail"
                Write-Host "Spanning has been disabled"
            }

            Read-Host -Prompt "Account Removed."
        }
    }
    End {
        Remove-PSSession -Session $SessionDC1
    }
}