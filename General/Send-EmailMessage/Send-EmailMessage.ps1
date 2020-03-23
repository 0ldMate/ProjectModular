<#
.Synopsis
   Sends Email from the local Outlook client.
.DESCRIPTION
    Sends email from local Outlook client to prevent any issues with your email being flagged as junk. Can be given multiple emails to send to.
    Gathers the email server and port via the Load-Variables script.
.EXAMPLE
    Send-EmailMessage
.EXAMPLE
    $EmailTo = "Bob@Bobvance.com;Michael@MichaelScott.com"
    Send-EmailMessage -emailto $emailto 
#>
function Send-EmailMessage {
    [CmdletBinding()]
    Param
    (
        # The email body 
        [string] $EmailBody,

        # Email address the email is to be sent to (can have multiple)
        [string] $EmailTo,

        # Subject of the email
        [string] $EmailSubject
    )
    Process
    {
        foreach ($EmailToSingle in $EmailTo) {
        $Outlook = New-Object -ComObject Outlook.Application
        $Mail = $Outlook.CreateItem(0)
        $Mail.To = $EmailToSingle
        $Mail.Subject = $EmailSubject
        $Mail.Body = $EmailBody
        $Mail.Send()
        }
    }
}