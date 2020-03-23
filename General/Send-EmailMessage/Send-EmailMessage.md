# Send-EmailMessage

Send-EmailMessage is a script used to send an email through the local outlook client rather than using send-mailmessage. This is used in situations where send-mailmessage is being flagged by Outlook. Using this creates and sends the email just as if you're sending it via the GUI.

# Prerequisites
Microsoft Outlook

# Usage
#Examples
Sends Email with subject Test to Bob@Vance.com
Send-EmailMessage -Emailbody "Test" -EmailTo "Bob@Vance.com" -EmailSubject "Test"

Sends an empty email message to Bob@Bobvance.com and Michael@MichaelScott.com
$EmailTo = "Bob@Bobvance.com;Michael@MichaelScott.com"
Send-EmailMessage -emailto $emailto 

# Parameters
-EmailBody <string>
The body of the email being sent

-EmailTo <string>
The email you're sending to

-EmailSubject <string>
The subject of the email being sent

# Further Help
For further help use Send-EmailMessage -?
