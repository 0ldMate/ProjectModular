## Installing Add-ons
ProjectModular runs without add-ons however there is a lot of functionality gained when enabling add-ons.
Each script has a help file mentioning what add-ons add to that script.

# Audit Document
This add-on is used to create a document with powershell and fills the fields out for auditing purposes when someone has left the company. 

Prerequisites
Microsoft Office Word (Tested with Office 365)


# AX
Microsoft Dynamics AX 2012 (https://docs.microsoft.com/en-us/dynamicsax-2012/appuser-itpro/introduction-to-microsoft-dynamics-ax-2012) is an ERP system.

This add-on is used to manipulate AX with powershell to create users and apply permissions.

How To Install
Open the Microsoft Dynamics AX installer and click through to the "Add or Modify Components" screen. Enable ".NET Business Connector" under the "Integration Components" section and the "Management Utilities" and complete the install process. This will install the AX PowerShell management tools.

This should be installed in the default folder:

"C:\Program Files\Microsoft Dynamics AX\60\ManagementUtilities\Microsoft.Dynamics.ManagementUtilities.ps1"


# Download PST (depreciated - using shared mailboxes instead)
This add-on is used to download the .pst directly from Office 365 with powershell when the user is removed.

How To Install
Open the link https://protection.office.com/ in Microsoft Edge
Sign into Admin Account > Search & Investigation > Content Search 
Create a new search > Modify Location > Choose users, groups or teams > Select any user > Start search 
Let the search run > Export the results 
Click the exported search > download results > Install the software > Input the export key and where you’d like to save the download 
Start the download > Open task manager > Find the process > Open the file location 
Copy all contents to C:\UnifiedExportTool\ 

This will allow you to use the export tool with powershell for the automatic .pst download.


# Email Reminder
This add-on is used to enable email reminders in Outlook.

Prerequisites
Microsoft Office Outlook (Tested with Office 365)


# Email
This add-on is used to enable emails in Outlook for some of the scripts. It is used in replacement for mail-message because of emails being falsely flagged as spam.

Prerequisites
Microsoft Office Outlook (Tested with Office 365)


# JIRA
JIRA (https://www.atlassian.com/software/jira) is "Simply Modern Service Desk Software" that is used to manage tickets for teams.

This add-on is used to manipulate JIRA Helpdesk with powershell to create and update tickets.

How To Install
Follow the instructions to install the JIRA Powershell Module from https://github.com/AtlassianPS/JiraPS


# Random Password
This add-on is used to randomise the password of accounts with powershell. 

Prerequisites
There are no prerequisites for this add-on.


# Spanning
Spanning (https://spanning.com/) is a "Cloud-to-Cloud SaaS Backup" that works with Office365 to backup emails, sharepoint and one drive.

This add-on is used to manipulate Spanning with powershell to enable and disable the licenses of users.

How To Install
Follow the instructions to install the Spanning Powershell Module from https://github.com/SpanningCloudApps/SB365-Powershell


