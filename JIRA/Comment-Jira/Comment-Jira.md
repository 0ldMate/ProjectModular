# Comment-Jira

Comment-Jira is a script used to create comments and worklogs in JIRA tickets. This is primarily used within other scripts rather than using it on its own.

# Prerequisites
JiraPS - Check Prerequisites folder for install instructions

# Usage
#Examples
Creates a comment and a worklog on a ticket given by the other scripts
Comment-Jira

Creates comment and worklog on ticket TEST-203
Comment-JIRA -JiraTicket "TEST-203" -JiraComment "Almost done" -JiraWorklog "Working on it" -JiraTimeSpent "00:10"

# Parameters
-JiraTicket <string>
Jira Ticket number

-JiraComment <string>
The comment input

-JiraWorkLog <string>
The worklog input

-JiraTimeSpent <string>
The time spent for task

# Further Help
For further help use Comment-Jira -?
