#ShowCurrentAV in WMI and Clear if Required - Written by Christine Jordan

#Set Execution Policy to Unrestricted
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Confirm

#Get the Current AV Product and Display
$antiVirusProduct = (Get-WmiObject -Namespace root/securitycenter2 -query "Select * from AntiVirusProduct" | Format-List displayName | out-string)
Write-Host "The Current Reported AV from WMI is: $antiVirusProduct"

#Ask if the user would like to clear the details and save to a variable
$answer = Read-Host "Do you want to clear the AV Info from WMI? y / n"

#if statement to clear data or not depending on users choice
if ($answer -eq "y") {
    (Get-WmiObject -namespace root/securitycenter2 -query "Select * from AntiVirusProduct" | Remove-WmiObject)  
    (Write-Host "The WMI Data Has Been Cleared, Please reboot PC for changes to take effect")
    ($restartPrompt = Read-Host "Would you like to restart now? y / n")
        if ($restartPrompt -eq "y")
            {Restart-Computer
        }else{Write-Host "Please restart computer when next convenient"}
}else{
    Write-Host "The WMI Info has not been cleared"
}

