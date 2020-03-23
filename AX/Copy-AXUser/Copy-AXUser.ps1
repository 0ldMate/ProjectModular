<#
.Synopsis
   Creates/Copies a new AX User and applies permissions
.DESCRIPTION
   Creates a new User in AX and applies permissions based off another user. This is used with the account creation script primarily. 
   Can be used to copy permissions to an already created account and can also be used outside of account creation script.
   Requires Dynamics AX 2012, AX 2012 Management Utilities and the Business Connector to be installed
   Collects variables from central file to run.
   Note: If you are generating a new user you must input all parameters.
.EXAMPLE
   Copy-AXUser
.EXAMPLE
   Copy-AXUser -AXUserName MJack -CopyUser BRoss 
.EXAMPLE
   Copy-AXUser -AXUserName MJack -CopyUser BRoss -SAMAccountName MJackson -AXDomain company.com.au
#>
function Copy-AXUser
{
    [CmdletBinding()]
    Param
    (
        # User's AX ID eg JSmith
        [string] $AXUserName,

        # Copy User's AX ID eg KSmith
        [string] $CopyUser,

        # Active Directory SAMAccountName (needed for creating new user) eg JSmith
        [string] $SAMAccountName,

        # AX Domain ID (needed for creating new user) eg company.com.au
        [string] $AXDomain
    )

    Begin
    {
        if (Test-Path -Path "C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"){
            . "C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"
        } else{
            Read-Host "Microsoft Dynamics AX 2012 Management Utilities is not installed. Please install it. If you do not, the AX part of this script will not work. Press Enter to continue or close script."
        }
    }
    Process
    {
        $AXUsername = if ($SAMAccountName.length -gt 5){
            $SAMAccountName.SubString(0,5)
        }
        else {
            $SAMAccountName
        }
        
        if (!(Get-AXUser -AXUserID $AXUsername*)){
            $AXNewUser = Read-Host "Can't find AX User with id $AXUsername. Make new user?"
            if ($AXNewUser -eq "Yes"){
                Write-Host "Waiting for AD Sync, sleeping 180 seconds"
                Start-Sleep -Seconds "180"
                New-AXUser -AccountType WindowsUser -AxUserID $AXUsername -UserName $SAMAccountName -UserDomain $AXDomain -errorvariable $NewAXError
            }
        }

        $Roles = Get-AXSecurityRole -AxUserID $CopyUser -ErrorVariable $AXError | Select-Object -ExpandProperty AOTName
        if ($AXError) {
            Write-Host "Error with copy username, trying to resolve."
            $CopyUserShort = $CopyUser.Substring(0,4)
            Get-AXUser -AXUserID "$CopyUsershort*" | Select-Object Name,AXUserID
            $FixedCopy = Read-Host -Prompt "AX Username - $copyuser is invalid, please input the correct User ID. Above are ID's of valid users with similar names."
            $Roles = Get-AXSecurityRole -AxUserID $FixedCopy | Select-Object -ExpandProperty AOTName
        }
        ForEach($Role in $Roles) {Add-AXSecurityRoleMember -AxUserID $AXUserName -AOTName $Role;Write-Host "Assigning $Role to $AXUsername"}
        
    }
    
}