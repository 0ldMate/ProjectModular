# Reset-ADPassword

Reset-ADPassword is a script used to reset the AD password of the new accounts created by create-account. This script is based off the same .csv file that allows the user to create accounts in bulk. This script currently:
- resets the account's password to either user input or randomly generated password
- sets the account to reset at logon
It connects to Active Directory and any other services enabled by the add-ons list.
Note: This process is in two parts, this is the second part of the script.

# Prerequisites
If add-ons are enabled, any prerequisites for that add-on.

# Add-Ons
JIRA Enabled
Allows the script to interact with JIRA Helpdesk and automatically update the account tickets

Spanning Enabled
Allows the script to enable the user license from Spanning Office 365

Random Password Enabled
Randomly generates the password using the New-PassPhrase script

Email Enabled
Allows the scripts to send emails to the manager with their new starters account information and instructions

# Usage
#Examples
Resets passwords of accounts based on the .csv file
Reset-ADPassword

# Parameters
-ImportedCSV <string>
Location of .csv

# Further Help
For further help use Reset-ADPassword -?
