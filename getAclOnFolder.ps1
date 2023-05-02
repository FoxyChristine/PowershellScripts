# Set the path of the directory you want to list the groups that have access
$directoryPath = "S:\"

# Get all the folders under the specified directory
$folders = Get-ChildItem $directoryPath -Directory -Recurse

# Create an empty array to hold the results
$results = @()

# Loop through each folder and get the groups that have access
foreach ($folder in $folders) {
    $acl = Get-Acl $folder.FullName
    $accessRules = $acl.Access | Where-Object { $_.IdentityReference -match "^(DOMAIN\GROUPNAME)" }

    # Add each group to the results array
    foreach ($accessRule in $accessRules) {
        $results += [PSCustomObject]@{
            FolderName = $folder.FullName
            GroupName = $accessRule.IdentityReference
        }
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path "C:\temp\FolderGroups.csv" -NoTypeInformation
