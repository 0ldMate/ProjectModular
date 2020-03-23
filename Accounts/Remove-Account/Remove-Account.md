# Remove-Account

Remove-Account is a script used to remove accounts when a user has left or been terminated. This script is based off a .csv file that allows the user to remove accounts in bulk. This script currently:
- removes the user from any groups
- changes the password
- moves files from a production server to an archive server (functionality has been commented out, uncomment to continue to use)
- searches for any computer tied to their account and moves it back to the computers OU
- sets up the email redirect with Office365
- then completes any other add-ons
It connects to Active Directory and any other services enabled by the add-ons list.
Note: This script does not delete accounts it simply moves them to an OU and sets a reminder to be deleted manually 30 days after.

# Prerequisites
Office365 for email redirects
If add-ons are enabled, any prerequisites for that add-on.

# Add-Ons
Email Reminder
Allows the script to create an email reminder in Outlook 30 days after the script was run to remind the admin to delete the account

Random Password Enabled
Makes all passwords randomly generated using the New-PassPhrase script

JIRA Enabled
Allows the script to interact with JIRA Helpdesk and automatically update the tickets

Spanning Enabled
Allows the script to remove the users license from Spanning Office 365

Audit Document
Allows the script to create a document for auditing purposes with some basic information on when the account was removed

Download PST (Depreciated - converting to mailbox has replaced this)
Allows the script to download the user's Outlook PST from Office365 using the unifiedexporttool

# Usage
#Examples
Removes accounts based on the .csv file
Remove-Account

# Parameters
-ImportedCSV <string>
Location of .csv

# Further Help
For further help use Remove-Account -?
