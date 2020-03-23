<#
.Synopsis
   Clears temp browsing files on selected computers
.DESCRIPTION
   Clears all temp files in internet explorer and chrome folders on specified machines.
   You can use a list of computer names in a file.
.EXAMPLE
   Clear-TempFiles -ComputerName DC
.EXAMPLE
   Clear-TempFiles -ComputerNameFile C:/temp/Computerfiles.txt
#>
function Clear-TempFiles
{
    [CmdletBinding()]
    Param
    (
        # Computer Name (can be fed multiple eg. server1,server2)
        [string] $ComputerName,

        # Computer Name list by file location (C:/Computers.txt)
        [string] $ComputerNameFile
    )

    Begin
    {
        if (!($UserCredential)) {
            Load-Variables
        }
        if ($ComputerNameFile){
            $ComputerName = Get-Content $ComputerNameFile
        }
        if ($JiraEnabled -eq "Yes"){
            if(!(Get-JiraSession)) {
                Connect-Jira
            }
        }
        Load-Variables
    }
    Process
    {
        foreach ($Computer in $ComputerName){
            Invoke-Command -ComputerName $Computer -Credential $UserCredential -ScriptBlock {
                $Names = Get-ChildItem C:\users\* | Select-Object -ExpandProperty Name
                foreach($Name in $Names){
                    $Path = "C:\Users\$Name\Appdata\Local\Microsoft\Windows\Temporary Internet Files"
                    if(Test-Path $Path){
                        (Get-ChildItem $Path -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue)
                    }
                    $Path2 = "C:\Users\$Name\AppData\Local\Google\Chrome\User Data\Default\Cache"
                    if(Test-Path $Path2){
                        (Get-ChildItem $Path2 -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue)
                    }
                }
            }
        }
    }   
    End
    {
        if ($JiraEnabled -eq "Yes"){
            New-JiraIssue -Project $JiraProject -IssueType $JiraClearTempIssueType -Summary $JiraClearTempSummary -Description $JiraClearTempDescription | Set-JiraIssue -Assignee $Assignee |Add-JiraIssueWorklog -TimeSpent $JiraClearTempWorkLogTime -Comment $JiraClearTempWorkLog -DateStarted (Get-Date)        
        }
    }
}