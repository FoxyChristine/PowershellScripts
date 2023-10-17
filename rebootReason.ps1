$eventIDs = @(1074, 6005, 6006, 6008)
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ID = $eventIDs
    StartTime = (Get-Date).AddDays(-30) # Adjust the time range as needed
}

foreach ($event in $events) {
    $time = $event.TimeCreated

    # Check if there's a value for $event.UserId
    if ($event.UserId) {
        # Get userid which is a SID
        $usersid = $event.UserId

        # Get it into readable format
        try {
            $sid = New-Object System.Security.Principal.SecurityIdentifier -ArgumentList $usersid
            $account = $sid.Translate([System.Security.Principal.NTAccount])
        } catch {
            $account = "Error translating SID"
        }
    } else {
        $account = "no user listed"
    }

    Write-Output "Reboot Time: $time"
    Write-Output "Account Used: $account"
    Write-Output ""
}