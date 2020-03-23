<#
.Synopsis
   Connects to Atlassian Jira Help Desk
.DESCRIPTION
   Connects to the JIRA Help Desk to be able to update tickets when scripts are run. Collects variables from central file to run.
.EXAMPLE
   Connect-JIRA
#>
function Connect-Jira {
    [CmdletBinding()]
    Param()

    Begin {
        Import-Module JiraPS
        if ((Get-JiraConfigServer) -ne $JIRAServer) {
            Set-JiraConfigServer -Server $JIRAServer
        }
        New-JiraSession -Credential $JiraCredential
    }
}