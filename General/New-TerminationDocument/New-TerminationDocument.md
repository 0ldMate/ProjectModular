# New-TerminationDocument

New-TerminationDocument is a script used to generate a new word document for terminated users. Used exclusively in the "Remove-Account" script, uses fields and data generated to automatically fill out this document. This is an Add-on.

By default it creates a document with the following layout:
Staff Termination

Staff Details
Name: 
Department: 
Employment End Date: 
Account
User Account Password Changed: Yes 
User Account Removed from Security and Dist Groups: Yes 
Remove VPN Access: Yes 
Moved User to Terminated Users OU: Yes 
User Account Deletion Date Yes 
Email
Email Redirection: Yes  
Mailbox Access: Yes 
Out of Office Setup: Yes 
Email Archive: Yes 
Data
Backup Data on User's PC: Yes 
Backup Users Data on OneDrive: Yes 
Provide Access to Management: Yes 

# Prerequisites
Microsoft Word

# Usage
#Examples
Generates and fills out a termination document
New-TerminationDocument

# Parameters

# Further Help
For further help use New-TerminationDocument -?
