# What is ProjectModular?
    ProjectModular is a set of scripts written in PowerShell that was created to automate basic sysadmin/support jobs. It was designed to be a super user friendly experience for those who do not have a lot of PowerShell experience. To do that, most variables call back to a central file that can be edited after download. This project is still being improved.

# Who can use ProjectModular?
    ProjectModular has been written so that anyone (with or without PowerShell knowledge) could pick it up, change a few fields and use it in their organisation to begin automating some tasks.

# What can ProjectModular do?
    There is a range of scripts in this project from very specific program scripts to generic scripts. The core scripts are the account creation and termination scripts which work in Active Directory environments. They both have add-ons that can be enabled in the config to add features like:
     - Automatic JIRA Helpdesk ticket creation/comments
     - Dynamics AX user creation
     - Spanning Office365 Backup applying/removing licenses
     - Email details to a manager/supervisor
     - Email meeting reminder to remove account
     - Self generating termination audit document
     - Download .pst from Office365
    There are also individual scripts that are for general purpose like:
     - Clearing Chrome and Internet Explorer temporary files for all users on servers
     - Collecting all AD groups and users in those groups
     - Finding all services that are set to automatic but haven't started
     - Querying AD description fields to find what computer a user owns
     - Generating a random password
     - Sending an email from Outlook locally on machine
     - RoboCopy files and get emailed a report upon completion

# Installing ProjectModular
    Depending on what add-ons you require depends on what pre-requisites need to be installed. 

# PREREQUISITES
Office365 as a mail server
Powershell3
If you enable certain add-ons:
Microsoft Office 365
Spanning 365 Backup
Microsoft Dynamics AX 2012
JIRA Helpdesk

To install ProjectModular download the .zip file and extract the file into C:\Program Files\WindowsPowerShell\Modules. (You may need to give your user full access permissions to allow you to edit files like .csv's)
Unblock the files by running the following command in an administrator powershell prompt in the directory that ProjectModular is in (ie C:\Program Files\WindowsPowershell\Modules\ProjectModular)
“Get-ChildItem -Path “*.ps*” -Recurse | Unblock-File”
Open up ProjectModular\General\Load-Variables\Load-Variables.ps1 and edit all the variables needed and save the file.

Project Modular is installed. Open Powershell and type Get-command -module ProjectModular to see all the commands available. This module will load every time you start PowerShell.

Note: You may need to edit security permissions on that folder for your user so you can save the files.

# Updating Project Modular
When updates are needed for ProjectModular, make sure to make a copy of the Load-Variables.ps1 file so you don't have to edit it again.

# TODO
GUI
More scripts
Mandatory fields in account creation
Automatic once a day script that runs with Jira pulling data from any ticket in that request type and removing that account
Reset-ADPassword enable Office365 licensing
    