# Create-Account

Create-Account is a script used to create accounts when a user has joined the company. This script is based off a .csv file that allows the user to create accounts in bulk. This script currently:
- creates the account
- copies the groups from one user to them
- moves the user to the appropriate OU
It connects to Active Directory and any other services enabled by the add-ons list.
Note: This process is in two parts, this is the first part of the script.

# Prerequisites
If add-ons are enabled, any prerequisites for that add-on.

# Add-Ons
JIRA Enabled
Allows the script to interact with JIRA Helpdesk and automatically update the tickets

AX Enabled
Allows the script to create the account in Dynamics AX

# Usage
#Examples
Creates accounts based on the .csv file
Create-Account

# Parameters
-ImportedCSV <string>
Location of .csv

# Further Help
For further help use Create-Account -?
