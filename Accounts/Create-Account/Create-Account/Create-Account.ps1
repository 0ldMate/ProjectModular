<#
.Synopsis
   Creates accounts with data from a csv
.DESCRIPTION
   Creates accounts with data from a csv in Active Directory and AX and updates a ticket in Jira.
   It can be used to create multiple accounts at a time depending on the data in the csv.
   Options available in this script:
        - AX
        - JIRA
   You must use the csv with this script.
.EXAMPLE
   Create-Account
#>
function Create-Account
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
        $ImportedCSV = Import-Csv $ImportedCSV
    }
    Process
    {
        $ImportedCSV | foreach {
            $Name = $_.Name
            $Firstname = $Name.Split(" ")[0]
            $Surname = $Name.Split(" ")[1]
            $EmailAddress = "$Firstname" + ".$Surname" + "$CompanyEmail"
            $Title = $_.Title
            $CopyUser = $_.CopyUser
            $Description = $_.Title
            $MobileNumber = $_.Mobilephone
            $PhoneNumber = $_.OfficePhone
            $DisplayName = $Name
            $SAMAccountName = $Firstname.Substring(0,1) + $Surname
            $UserPrincipal = "$SAMAccountName" + "$CompanyEmail"

            $TargetUser = Get-ADUser -Identity $CopyUser -Properties *
            $TargetOU = $TargetUser.DistinguishedName -replace "CN=$($TargetUser.CN),"
            $TargetGroups = $TargetUser.MemberOf
            $TargetManager = $TargetUser.Manager
            $TargetDepartment = $TargetUser.Department

            $Password = Read-Host -Prompt "Input password"
            Load-Variables

            New-ADUser -Name $Name -GivenName $FirstName -Surname $Surname -EmailAddress $EmailAddress -Title $Title -Department $TargetDepartment -MobilePhone $MobileNumber -OfficePhone $PhoneNumber -DisplayName $DisplayName -SamAccountName $SAMAccountName -Manager $TargetManager -Company $Company -Fax $Fax -StreetAddress $StreetAddress -City $City -PostalCode $PostalCode -State $State -Country $Country -ScriptPath $ScriptPath -HomePage $HomePage -UserPrincipalName $UserPrincipal -Description $Description
            $TargetGroups | Add-ADGroupMember -Members $SAMAccountName
            $NewObjectID = Get-ADUser -Identity $SAMAccountName | Select-Object -ExpandProperty ObjectGUID
            Move-ADObject -Identity $NewObjectID -TargetPath $TargetOU
            Set-ADAccountPassword $SAMAccountName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$Password" -force)
            Set-ADUser -Identity $SAMAccountName -Enabled $true
            Write-Host "$Name's AD account has been created. If the options are enabled the Jira ticket will now be updated and the AX account will be created."

            if ($JiraEnabled -eq "Yes"){
                $TicketNumber = $_.TicketNumber
                $Ticket = "$JiraProject" + "-" + "$TicketNumber"
                Add-JiraIssueComment -Issue "$Ticket" -Comment "$JiraCreationComment"  
                Add-JiraIssueWorklog -Issue $Ticket -TimeSpent "00:15" -Comment $JiraCreationWorkLog -DateStarted (Get-Date)
            }

            if ($AXEnabled -eq "Yes"){
                Copy-AXUser -Copyuser $CopyUser -SAMAccountName $SAMAccountName -AXDomain $AXDomain
            }
            Read-Host -Prompt "Account Created."
        }
    }
    End
    {
        Remove-PSSession -Session $SessionDC1
    }
}