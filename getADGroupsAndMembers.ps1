# Set the path of the OU you want to list the groups and members for
$ouPath = "OU=MyOU,DC=example,DC=com"

# Get all the groups in the specified OU
$groups = Get-ADGroup -Filter * -SearchBase $ouPath

# Create an empty array to hold the results
$results = @()

# Loop through each group and get its members
foreach ($group in $groups) {
    $members = Get-ADGroupMember -Identity $group -Recursive | Select-Object -Property Name, SamAccountName, ObjectClass

    # Add each member to the results array
    foreach ($member in $members) {
        $results += [PSCustomObject]@{
            GroupName = $group.Name
            GroupSamAccountName = $group.SamAccountName
            MemberName = $member.Name
            MemberSamAccountName = $member.SamAccountName
            MemberType = $member.ObjectClass
        }
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path "C:\temp\GroupMembers.csv" -NoTypeInformation
