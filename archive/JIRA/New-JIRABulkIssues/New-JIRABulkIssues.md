# New-JIRABulkIssues

New-JIRABulkIssues is a script used create bulk JIRA tickets from a csv file. It creates a session with Jira over PowerShell and creates the tickets one by one based off the fields in the csv. Edit the csv before running this.
You may need to edit the transition number for your JIRA Instance.

# Prerequisites
JiraPS - Check Prerequisites folder for install instructions

# Usage
#Examples
Creates bulk issues
New-JIRABulkIssues

Creates bulk issues for file specified and transitions them to the specified status
New-JIRABulkIssues -JiraIssuecsv "C:\issues.csv" -JiraTransition "42"

# Parameters
-JiraIssuecsv <string>
Jira Issue csv location

-JiraTransition <string>
Jira transition number to move the issues to, ie "in progress"

# Further Help
For further help use New-JIRABulkIssues -?
