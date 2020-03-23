# Load-Variables

Load-Variables is the central script to ProjectModular. This is the core file that should be edited before using the module. It holds a large amount of variables that are called throughout the entire module and is what allows customisation.

# Add-Ons
Add-Ons are enabled in this file for the use throughout the module. Enabling them is as simple as changing the designated fields to "Yes". The add-ons available are as follows:

Email Enabled
Allows certain scripts to send emails if required ie sending a manager their new starters account information 

Email Reminder
Allows the account removal script to create an email reminder in Outlook 30 days after the script was run to remind the admin to delete the account

Random Password Enabled
Makes all passwords randomly generated using the New-PassPhrase script

JIRA Enabled
Allows multiple scripts to interact with JIRA Helpdesk and automatically create tickets and make comments/worklogs

Spanning Enabled
Allows the account creation and removal scripts to make changes to Spanning Office 365 licenses

AX Enabled
Allows the account creation script to create the account in Dynamics AX

Audit Document
Allows the account removal script to create a document for auditing purposes

Download PST (Depreciated(commented out) - Office365 shared mailbox replaces this)
Allows the account removal script to download the user's Outlook PST from Office365

# Usage
#Examples
Loads the variables in the file
Load-Variables

# Parameters

# Further Help
For further help use Load-Variables -?
