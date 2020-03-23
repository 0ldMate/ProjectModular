# RCopy-FilesWithEmail

RCopy-FilesWithEmail is a script used to copy files from one location to another using Robocopy and then send a follow up email with the logs to confirm completion. Email contains infomation on the transfer and if any files didn't get copied.

# Usage
#Examples
Copies files from C:\Source to C:\Destination and emails the log to test2@testemail.com
RCopy-FilesWithEmail -sourcefolder C:\Source -destinationfolder C:\Destination -logfile C:\log.txt -emailfrom test@testemail.com -emailto test2@testemail.com -emailsubject "This is a test"


Copies files from C:\SourceFolder to C:\DestinationFolder and emails the log log.txt to test2@testemail.com
$Sourcefolder = C:\Sourcefolder
$Destinationfolder = C:\Destinationfolder
$Logfile = C:\log.txt
$Emailfrom = Test@testemail.com
$Emailto = Test2@testemail.com
$EmailSubject = "This is a test"
RCopy-fileswithemail -sourcefolder $sourcefolder -destinationfolder $destinationfolder -logfile $logfile -emailfrom $emailfrom -emailto $emailto -emailsubject $emailsubject 


# Parameters
-SourceFolder <string>
Name of the folder to copy from

-DestinationFolder <string>
Name of the folder to copy to

-LogFile <string>
Location to make the log file

-EmailFrom <string>
The email you want it be sent from

-EmailTo <string>
The email it is being sent to

-EmailSubject <string>
Subject of the email

# Further Help
For further help use RCopy-FilesEmail -?
