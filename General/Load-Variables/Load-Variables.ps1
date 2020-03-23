<#
.Synopsis
   Loads all the variables for the scripts
.DESCRIPTION
   Loads prefilled variables that are used in the module.
.EXAMPLE
   Load-Variables
#>
function Load-Variables {
        [CmdletBinding()]
        Param()
    
        Process {
    ##########################DO NOT EDIT ABOVE THIS LINE#################################
    

            ################## COMMON CHANGES START ####################################

            $global:AdminUsername = "Nick.admin"
            $global:Office365Username = "Nick.admin@DunderMifflin.com"
            $global:JiraUsername = "Nick.Jira"
            $global:CompanyEmail = "@DunderMifflin.com"
                # Script output file location
            $global:ScriptOutputLocation = $Env:USERPROFILE
                ### Email Reminders ###
    
            $global:OutlookEmail = "Nick@DunderMifflin.com"

                ### JIRA ###
    
            $global:JiraProject = "DUN"
            $global:JIRAIssueType = "TECH HELP"
            $global:Assignee = "Nick"
            $global:JiraServer = "http://Jira.DunderMifflin.com"

                ### SPANNING ###
    
            $global:SpanningPath = "~\Downloads\SB365-Powershell-master\SpanningO365"
            $global:SpanningAPI = "APIKEY"
            $global:SpanningRegion = ""
            $global:SpanningAdminEmail = $Office365Username

            ############# COMMON CHANGES END ######################

            $global:Company = "Dunder Mifflin Paper Company, Inc"
            $global:StreetAddress = "123 Fake Street"
            $global:City = "City"
            $global:PostalCode = "123456"
            $global:State = "State"
            $global:Country = "Country"
            $global:ScriptPath = ""
            $global:HomePage = "www.DunderMifflinPaper.com"
    # Domain Controller Server
            $global:DC1 = "NicksServer"
    # file server that files are located 
    # NOT USED
            $global:ServerFiles = "\\KevinsServer\Cake"
    # backup server files are being moved to 
    # NOT USED
            $global:BackupDestination = "\\NicksServer\TerminatedEmployees"
            
    # email auto reply    
            $global:AutoReply = @"
            I have left $Company as of $TLastDay.
            Please email any further requests to $RedirectEmail
            Regards,
            $Tuser
"@

    # Choose the you'd Add-On like to load by typing "Yes" or "No". What these add-ons do will be located in the .md file.
            $global:EmailEnabled = "Yes"
            $global:EmailReminder = "Yes"
            $global:RandomPasswordEnabled = "Yes"
            $global:JIRAEnabled = "Yes"
            $global:SpanningEnabled = "Yes"
            $global:AXEnabled = "Yes"
            $global:AuditDocument = "Yes"
            $global:DownloadPST = "Yes"
    
    ### Loading Credentials ###
    
            if (!($UserCredential)) {
                $global:UserCredential = Get-Credential -UserName $AdminUsername -Message "Enter domain admin credentials"
            }
            if (!($Office365UserCredential)) {
                $global:Office365UserCredential = Get-Credential -UserName $Office365Username -Message "Enter office365 admin email"
            }
            if ($JIRAEnabled -eq "Yes"){
                    if (!($JIRACredential)){
                            $global:JIRACredential = Get-Credential -UserName $JIRAUsername -Message "Enter JIRA credentials"
                    }
            }
    
    ### EmailEnabled ###
    # Account Creation Email Details
            $global:EmailSubjectAccountCreation = "$Name's Account Details" 
            $global:EmailAccountCreation = @"
            Hi $Manager,
            This is the account information for $Name
            Their Username is $SAMAccountName
            Their password is $Password
            Once they have signed in they will be requested to change their password. Their new password must be 12 characters long.
            Thanks
            IT
    
            *THIS IS AN AUTOMATED EMAIL FROM A SCRIPT. IF SOMETHING APPEARS INCORRECT PLEASE EMAIL IT.*
"@   
    
    # Account Creation Ticket Details
            $global:JiraCreationComment = @"
            $Name's account has been created. 
            Once the account has been set up on the machine, run Reset-ADPassword.
            AX Account has been created. Worker needs to be created manually and the relationship needs to be linked.
            
            *If something is incorrect, this is all automatic from account creation script.*
"@
            $global:JiraCreationWorkLog = @"
            Account has been created by script. 
            Username is $SAMAccountName
            Password is $Password
"@
            $global:JiraCreationComment2 = @"
            $Name's account has been created. 
            Email has been set to $Manager including the username, email, password and instructions on how to reset their password.
            Password will be forced to change at login.
    
            *This is an automated message*
"@
    
    # Account Termination Ticket Details
            $global:JiraTerminationComment = @"
            $TUser's account has been terminated. Files have been moved to their backup folder.
    
            *If something is incorrect, this is all automatic from account termination script.*
"@
            $global:JiraTerminationWorkLog = @"
            Account has been terminated.
"@
        
    # Clear Temp Files Ticket Details
            $global:JiraClearTempWorkLog = @"
            Temp internet data has been cleared.        
"@      
            $global:JiraClearTempWorkLogTime = "00:10"
            $global:JiraClearTempIssueType = "IT Help"
            $global:JiraClearTempSummary = "Cleared Temporary Browsing Data"
            $global:JiraClearTempDescription = "$ComputerName"
    
    ### Download PST ###
    # NO LONGER USED
    
            $global:exportlocation = "C:\Users\NickIT\Desktop\scripts" #enter the path to your export here !NO TRAILING BACKSLASH!
    
            $global:exportexe = "C:\UnifiedExportTool\microsoft.office.client.discovery.unifiedexporttool.exe" #path to your microsoft.office.client.discovery.unifiedexporttool.exe file. Usually found somewhere in %LOCALAPPDATA%\Apps\2.0\
    
            $global:exporttemplate = @'
    Container url: {ContainerURL*:https://xicnediscnam.blob.core.windows.net/da3fecb0-4ed4-447e-0315-08d5adad8a5a}; SAS token: {SASToken:?sv=2014-02-14&sr=c&si=eDiscoveryBlobPolicy9%7C0&sig=RACMSyH6Cf0k4EP2wZSoAa0QrhKaV38Oa9ciHv5Y8Mk%3D}; Scenario: General; Scope: BothIndexedAndUnindexedItems; Scope details: AllUnindexed; Max unindexed size: 0; File type exclusions for unindexed: <null>; Total sources: 2; Exchange item format: Msg; Exchange archive format: IndividualMessage; SharePoint archive format: SingleZip; Include SharePoint versions: True; Enable dedupe: EnableDedupe:True; Reference action: "<null>"; Region: ; Started sources: StartedSources:3; Succeeded sources: SucceededSources:1; Failed sources: 0; Total estimated bytes: 12,791,334,934; Total estimated items: 143,729; Total transferred bytes: {TotalTransferredBytes:7,706,378,435}; Total transferred items: {TotalTransferredItems:71,412}; Progress: {Progress:49.69%}; Completed time: ; Duration: {Duration:00:50:43.9321895}; Export status: {ExportStatus:DistributionCompleted}
    Container url: {ContainerURL*:https://zgrbediscnam.blob.core.windows.net/5c21f7c7-42a2-4e24-9e69-08d5acf316f5}; SAS token: {SASToken:?sv=2014-02-14&sr=c&si=eDiscoveryBlobPolicy9%7C0&sig=F6ycaX5eWcRBCS1Z5nfoTKJWTrHkAciqbYRP5%2FhsUOo%3D}; Scenario: General; Scope: BothIndexedAndUnindexedItems; Scope details: AllUnindexed; Max unindexed size: 0; File type exclusions for unindexed: <null>; Total sources: 1; Exchange item format: FxStream; Exchange archive format: PerUserPst; SharePoint archive format: IndividualMessage; Include SharePoint versions: True; Enable dedupe: True; Reference action: "<null>"; Region: ; Started sources: 2; Succeeded sources: 2; Failed sources: 0; Total estimated bytes: 69,952,559,461; Total estimated items: 107,707; Total transferred bytes: {TotalTransferredBytes:70,847,990,489}; Total transferred items: {TotalTransferredItems:100,808}; Progress: {Progress:93.59%}; Completed time: 4/27/2018 11:45:46 PM; Duration: {Duration:04:31:21.1593737}; Export status: {ExportStatus:Completed}
'@

    ### AX ###
            $global:AXDomain = "DunderMifflin.com"
            $global:AXCompany = "DunderMifflin.com"
    #########################DO NOT EDIT BELOW THIS LINE#########################
        }
    
    }