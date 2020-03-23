<#
.Synopsis
   Copies files using RoboCopy with a follow up email.
.DESCRIPTION
   Uses RoboCopy to copy files from one location to another then emails the results to an email with the attached log file.
   Gathers the email server and port via the Load-Variables script.
.EXAMPLE
   RCopy-FilesWithEmail -sourcefolder C:\Sourcefolder -destinationfolder C:\Destinationfolder -logfile C:\log.txt -emailfrom test@testemail.com -emailto test2@testemail.com -emailsubject "This is a test"
.EXAMPLE
    $Sourcefolder = C:\Sourcefolder
    $Destinationfolder = C:\Destinationfolder
    $Logfile = C:\log.txt
    $Emailfrom = Test@testemail.com
    $Emailto = Test2@testemail.com
    $EmailSubject = "This is a test"
    RCopy-fileswithemail -sourcefolder $sourcefolder -destinationfolder $destinationfolder -logfile $logfile -emailfrom $emailfrom -emailto $emailto -emailsubject $emailsubject 
#>
function RCopy-FilesWithEmail {
    [CmdletBinding()]
    Param
    (
        # Source folder to be copied from
        [string] $SourceFolder,

        # Destination folder to be copied to
        [string] $DestinationFolder,

        # Location to create the log file
        [string] $Logfile,

        # Email address the email is to come from
        [string] $EmailFrom,

        # Email address the email is to be sent to
        [string] $EmailTo,

        # Subject of the email
        [string] $EmailSubject = "$SourceFolder Robocopy"
    )
    Process
    {
        Robocopy $SourceFolder $DestinationFolder /MIR /E /V /NP /LOG:$Logfile /Z /R:3 /W:60 
        $LogFileContents = Select-String -Path $Logfile -Pattern "Times :" -Context 4, 6 | ForEach-Object {
            $_.Context.PreContext
            $_.Line
            $_.Context.PostContext
        } | Out-string
    }
    End
    {
        $emailBody = "$($logFileContents)"
        Send-MailMessage -Attachments $Logfile -SmtpServer $SMTPServer -Subject $EmailSubject -Body $EmailBody -From $EmailFrom -To $EmailTo
    }
}