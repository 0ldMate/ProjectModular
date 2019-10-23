<#
.Synopsis
   Comments on and adds a worklog to the Atlassian Jira Help Desk
.DESCRIPTION
   Connects to the JIRA Help Desk to be able to comment and add work logs to tickets. Collects variables from central file to run.
.EXAMPLE
   Comment-JIRA
.EXAMPLE
   Comment-JIRA -JiraTicket "TEST-203" -JiraComment "Almost done" -JiraWorklog "Working on it" -JiraTimeSpent "00:10"
#>
function Comment-Jira {
    [CmdletBinding()]
    Param
    (
        # Jira Ticket Number eg "TEST-201"
        [string] $JiraTicket,

        # The comment you wish to add to the ticket eg "comment example here"
        [string] $JiraComment,
        
        # The Worklog you wish to add to the ticket eg "Work done"
        [string] $JiraWorkLog,
        
        # The amount of time spent you wish to add to the ticket eg "00:15"
        [string] $JiraTimeSpent
    )

    Begin {
        if (!(Get-JiraSession)) {
            Connect-Jira
        }
    }

    process {
      Add-JiraIssueComment -Issue "$JiraTicket" -Comment "$JiraComment"  
      Add-JiraIssueWorklog -Issue $JiraTicket -TimeSpent "$JiraTimeSpent" -Comment $JiraWorkLog -DateStarted (Get-Date)
   }
}