import-module ActiveDirectory
$counter = 0
$nameselected = "no"
$server = "image$counter"
$ErrorActionPreference = 'SilentlyContinue'

Do { 
    Write-Host "Checking for existance of $server."
    if (Get-ADComputer -Identity $server) {
    Write-Host "Count is $counter."
    $global:counter++
    $server = "image$counter"
    Write-Host "New count is $counter."
    }
}
Until ( ( -not $( Get-ADComputer -Identity $server)) )
    $nameslected = "yes"
    Write-Host "The name will be $server."

Get-NetIPConfiguration
$DNS = "10.116.0.207","10.115.104.100"
$wmi.SetDNSServerSearchOrder($DNS)
Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses 10.116.0.207,10.115.104.100,10.64.97.10
Set-DnsClientServerAddress -InterfaceIndex 12 -ResetServer
Restart-Computer

$computername = Read-Host
 
$renamecomputer = $true
if ($computername -eq "" -or $computername -eq $env:computername) { $computername = $env:computername; $renamecomputer = $false }
 
$credentials = New-Object System.Management.Automation.PsCredential("XXXXXX\administrator", (ConvertTo-SecureString "MYPASSWORD" -AsPlainText -Force))

Write-Host "Adding $computername to the domain"

Add-Computer -DomainName "MYDOMAIN" -Credential $credentials -OUPath CN=Computers,DC=MY,DC=DOMAIN,DC=com
if ($renamecomputer -eq $true) { Rename-Computer -NewName $computername -DomainCredential $credentials -Force }
Restart-Computer
