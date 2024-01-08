#Get AD Usernames
$users = Get-ADUser -Filter * -SearchBase "ou=Departments, dc=lovattsmedia,dc=com"
$usernames = @()

foreach ($user in $users) {
    $usernames += $user.SamAccountName
}

#Generate New Proxy Address
foreach ($username in $usernames) {
    $user = Get-AdUser -Filter {samAccountName -eq $username}
    if ($user) {
        $newProxyAddress = "smtp:$username@<domain>.onmicrosoft.com"

        if ($user.proxyAddresses -notcontains $newProxyAddress) {
            $user.proxyAddresses += $newProxyAddress
        set-ADUser -Identity $user.SamAccountName -add @{proxyAddresses =$newProxyAddress}
        }
    }

}