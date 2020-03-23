<#
.Synopsis
   Creates word termination document for user
.DESCRIPTION
    Creates a word document for auditing purposes. This document can be customised and changed to fit auditing needs.
    This script is used in part with the Remove-Account script.
    All fields will be filled out when the script is run.
.EXAMPLE
   New-TerminationDocument
#>
function New-TerminationDocument
{
    [CmdletBinding()]
    param()

    Process
    {
        $Word = New-Object -ComObject Word.Application
        $Word.Visible = $True
        $Word.Documents.Add() | Out-Null
        $Selection = $Word.Selection
        $Selection.Font.Size = "14"
        $Selection.TypeText("Staff Termination")
        $Selection.TypeParagraph()
        $Selection.TypeParagraph()
        $Selection.Font.Size = "12"
        $Selection.TypeText("Staff Details")
        $Selection.TypeParagraph()
        $Selection.font.Size = "11"
        $Selection.Font.Bold = 1
        $Selection.TypeText("Name: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("$Tuser")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Department: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("$Department")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Employment End Date: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("$TLastDay")
        $Selection.TypeParagraph()
        
        $Selection.Font.Size = "12"
        $Selection.TypeText("Account")
        $Selection.TypeParagraph()
        $Selection.font.Size = "11"
        $Selection.Font.Bold = 1
        $Selection.TypeText("User Account Password Changed: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("User Account Removed from Security and Dist Groups: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Remove VPN Access: ")
        $Selection.Font.Bold = 0 
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Moved User to Terminated Users OU: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("User Account Deletion Date ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $TDate")
        $Selection.TypeParagraph()
        
        $Selection.Font.Size = "12"
        $Selection.TypeText("Email")
        $Selection.TypeParagraph()
        $Selection.font.Size = "11"
        $Selection.Font.Bold = 1
        $Selection.TypeText("Email Redirection: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate $UserRedirect")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Mailbox Access: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Out of Office Setup: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Email Archive: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        
        $Selection.Font.Size = "12"
        $Selection.TypeText("Data")
        $Selection.TypeParagraph()
        $Selection.font.Size = "11"
        $Selection.Font.Bold = 1
        $Selection.TypeText("Backup Data on User's PC: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Backup Users Data on OneDrive: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
        $Selection.Font.Bold = 1
        $Selection.TypeText("Provide Access to Management: ")
        $Selection.Font.Bold = 0
        $Selection.TypeText("Yes $CurrentDate")
        $Selection.TypeParagraph()
    
    }
}