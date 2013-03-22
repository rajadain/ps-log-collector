param(
    [string]$source = "C:\inetpub\logs\LogFiles",
    [string]$target = "."
    )

Import-Module WebAdministration # All the IIS control goodness

foreach ($site in Get-Website) { # Every site configured in IIS
    $ID = $site.ID

    # Assemble log file path
    $LogFilePath = $source + "\W3SVC" + $ID
    
    # If the log file path exists
    if (Test-Path $LogFilePath) {
        # Assemble destination path
        $destin = $target + "\" + $site.Name
        
        # Create a directory with site name in destination folder if one doesn't exist already
        if (!(Test-Path $destin)) {
            New-Item $destin -type directory
        }
        
        # Copy all logs files to destination
        robocopy $LogFilePath $destin
        
        # Debug Info
        "Copied " + (Get-ChildItem ($LogFilePath)).Count + " items from " + $LogFilePath + " to " + $destin
    }
}