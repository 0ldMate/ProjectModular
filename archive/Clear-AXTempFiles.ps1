Import-Module ActiveDirectory
$Computers = Get-ADComputer -Filter {OperatingSystem -like "Windows 10*"} -Properties cn | Where-Object { $_.enabled }
foreach ($computer in $computers){
if(Test-Connection -ComputerName $Computer.Name -Count 3 -Quiet){
    $Users = Get-ChildItem -Path "\\$($Computer.name)\C$\Users"
    foreach($user in $users){
        Get-ChildItem -Path "\\$($Computer.Name)\C$\Users\$User\Appdata\local\*" -Include *.auc,*.kti | Remove-Item
}
}
else{
"$computer.Name is unreachable"
}
    
}
