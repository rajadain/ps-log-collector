Import-Module WebAdministration # All the IIS control goodness

# Initialize default source directory
$SourceDirectory = "C:\inetpub\logs\LogFiles"

foreach ($site in Get-Website) { # Every site configured in IIS
    $ID = $site.ID

    # Print the site ID, Name, and number of logs
    "ID = " + $ID + " Name = " + $site.Name + " NumLogs = " + (Get-ChildItem ($SourceDirectory + "\W3SVC" + $ID)).Count
}