Write-Host "Please enter your desired computer name: [Default $env:computername]:"
$computername = Read-Host
 
$renamecomputer = $true
if ($computername -eq "" -or $computername -eq $env:computername) { $computername = $env:computername; $renamecomputer = $false }
 
$credentials = New-Object System.Management.Automation.PsCredential("seadata\administrator", (ConvertTo-SecureString "V!z!0r0ck$" -AsPlainText -Force))

Write-Host "Adding $computername to the domain"

Add-Computer -DomainName "seadata.vizio.com" -Credential $credentials -OUPath CN=Computers,DC=seadata,DC=vizio,DC=com
if ($renamecomputer -eq $true) { Rename-Computer -NewName $computername -DomainCredential $credentials -Force }
Restart-Computer