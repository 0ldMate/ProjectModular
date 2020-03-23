<#
.Synopsis
   Downloads a user's outlook pst from Office365
.DESCRIPTION
    Downloads a user's outlook pst from Office365 including all cached emails. This process is run in the background using Micrsoft's Download tool.
    Creates an Office365 search, exports it and then proceeds to download it.
    Used primarily in the Remove-Account.ps1 termination script.
    Gathers the email server and port via the Load-Variables script.
    Further assistance check out https://techcommunity.microsoft.com/t5/Office-365/Export-to-PST-via-Powershell/td-p/95007
.EXAMPLE
    Download-Outlookpst
.EXAMPLE
    $Office365UserCredential
    $TUser = "Bob Vance"
    $exportlocation = "C:\ScriptDownloads"
    $Exportexe = "C:\UnifiedExportTool\microsoft.office.client.discovery.unifiedexporttool.exe"
    Send-EmailMessage -emailto $emailto 
#>
function Download-Outlookpst 
{
    [CmdletBinding()]
    Param
    (
        # Name of the user
        [string] $TUser,

        # Location of the Unified Export Tool
        [string] $Exportexe = "C:\UnifiedExportTool\microsoft.office.client.discovery.unifiedexporttool.exe",

        # Export to this location
        [string] $exportlocation
    )

    Begin {
        if (!(Get-PSSession | Where-Object {$_.Name -eq "Microsoft.Exchange"})) {
            Connect-Office365Exchange
        }
        Import-PSSession $Session365Exchange -CommandName *ComplianceSearch* -AllowClobber
    }
    Process {
        Write-Host "Preparing Mailbox to be downloaded"
        New-ComplianceSearch -Name "$Tuser" -ExchangeLocation "$TUser" | Start-ComplianceSearch
        Write-Host "Waiting for Search to Complete"
        do {
            Start-Sleep -s 5
            $ComplianceSearch = get-complianceSearch "$Tuser"
        }
        while ($ComplianceSearch.Status -ne 'Completed')
    
        New-ComplianceSearchAction -SearchName $Tuser -Export -Format FxStream -ExchangeArchiveFormat PerUserPst
        $TuserExport = $Tuser + "_Export"
        Write-Host "Waiting for Export to Complete"
        do {
            Start-Sleep -s 60
            $ComplianceExport = get-ComplianceSearchAction -Identity $TuserExport -IncludeCredential -Details | Select-Object -ExpandProperty Results | ConvertFrom-String -TemplateContent $exporttemplate
            $ComplianceExportProgress = $ComplianceExport.Progress
            Write-Host "Export still exporting, progress is $ComplianceExportProgress, waiting 60 seconds"
        }
        while ($ComplianceExportProgress -ne '100.00%')

        $exportdetails = Get-ComplianceSearchAction -Identity $TuserExport -IncludeCredential -Details | Select-Object -ExpandProperty Results | ConvertFrom-String -TemplateContent $exporttemplate
        $exportdetails
        $exportcontainerurl = $exportdetails.ContainerURL
        $exportsastoken = $exportdetails.SASToken

        Write-Host "Initiating download"
        Write-Host "Saving export to: " $exportlocation
        $arguments = "-name ""$Tuser""", "-source ""$exportcontainerurl""", "-key ""$exportsastoken""", "-dest ""$exportlocation""", "-trace true"
        Start-Process -FilePath "$exportexe" -ArgumentList $arguments

        $started = $false
        Do {
            $status = Get-Process microsoft.office.client.discovery.unifiedexporttool -ErrorAction SilentlyContinue
            If (!($status)) {
                Write-Host 'Waiting for process to start' ; Start-Sleep -Seconds 5 
            }

            Else {
                Write-Host 'Process has started' ; $started = $true
            }
        }Until ( $started )  

        Do {
            $ProcessesFound = Get-Process | Where-Object { $_.Name -like "*unifiedexporttool*" }
            If ($ProcessesFound) { 
                Write-Host "Export still downloading, waiting 60 seconds"
                Start-Sleep -s 60
            }
        }Until (!$ProcessesFound)
    }
}
