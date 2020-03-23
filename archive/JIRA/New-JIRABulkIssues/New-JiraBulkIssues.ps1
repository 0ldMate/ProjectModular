<#
.Synopsis
   Creates bulk JIRA issues from .csv
.DESCRIPTION
   Connects to the JIRA Help Desk to be able to create bulk tickets from .csv data.
   Creates tickets, assigns the ticket to a user and transitions the issue to in progress.
   If there is no JIRA session created by the central script.
   The .csv is located in the same location as the script.
   THIS SCRIPT NEEDS TO BE USED WITH THE CSV.
.EXAMPLE
   New-JiraBulkIssues
#>
function New-JiraBulkIssues {
    [CmdletBinding()]
    param(
        [string]$JIRAIssuecsv = "$PSScriptRoot\JiraTickets.csv",

        [string]$JIRATransition = "421"
    )
    Begin {
        if (!(Get-JiraSession)) {
            Connect-Jira
        }
        $JIRAIssues = Import-Csv $JIRAIssuecsv
    }

    Process {
        foreach ($JIRAIssue in $JIRAIssues) {
            $Description = $JIRAIssue.Description
            $Reporter = $JIRAIssue.Reporter
            $Assignee = $JIRAIssue.Assignee
            $Summary = $JIRAIssue.Summary
            $IssueType = $JIRAIssue.IssueType
            $fields = @{
                duedate = $JIRAIssue.DueDate
            }
            New-JiraIssue -Project $JIRAProject -IssueType $IssueType -Summary $Summary -Description $Description -Reporter $Reporter -Fields $fields | Set-JiraIssue -Assignee $Assignee -PassThru -SkipNotification | Invoke-JiraIssueTransition -Transition $JIRATransition
        }
        
    }
}