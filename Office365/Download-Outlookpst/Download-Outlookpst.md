# Download-Outlookpst

Download-Outlookpst is a script used in the remove account script to download the users .pst from Office365 servers. Connects to Office 365, creates a search for their user and exports it to allow the .pst to be downloaded via the Unified Export Tool.

NOTE: This script is depreciated due to being able to convert user's mailboxes to shared mailboxes instead. The data is still in the scripts, just commented out.

# Prerequisites
Unified Export Tool - Check Prerequisites folder for install instructions

# Usage
#Examples
Downloads Outlook PST for user Bob Vance
Download-Outlookpst -TUser "Bob Vance" -exportexe "C:\UnifiedExportTool\microsoft.office.client.discovery.unifiedexporttool.exe"

# Parameters
-TUser <string>
Name of the user

-Exportexe <string>
Location of the Unified Export Tool

-ExportLocation <string>
Location to be exported to

# Further Help
For further help use Download-Outlookpst -?
