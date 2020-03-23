$Scripts = Get-ChildItem -Path "$PSScriptRoot\*.ps1" -Recurse -ErrorAction SilentlyContinue

foreach($script in $scripts){
    try {
        . $script.fullname
	Export-ModuleMember -Function $Script.Basename
    }
    catch {
        Write-Error -Message "Failed to import function $_"
    }
}