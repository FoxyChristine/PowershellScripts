$users = Get-ADUser -Filter * -Properties UserPrincipalName,passwordlastset
$users | Select-Object UserPrincipalName,passwordlastset | Export-Csv -Path C:\Temp\ADUsers.csv -NoTypeInformation