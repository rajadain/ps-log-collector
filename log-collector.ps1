Import-Module WebAdministration # All the IIS control goodness

# Initialize default destination directory for now
$DestinDirectory = "C:\Users\Ttuhinanshu\myLogs"

# Initialize default source directory
$SourceDirectory = "C:\inetpub\logs\LogFiles"

foreach ($site in Get-Website) { # Every site configured in IIS
    $ID = $site.ID

    # Assemble log file path
    $LogFilePath = $SourceDirectory + "\W3SVC" + $ID
    
    # If the log file path exists
    if (Test-Path $LogFilePath) {
        # Assemble destination path
        $Target = $DestinDirectory + "\" + $site.Name
        
        # Create a directory with site name in destination folder if one doesn't exist already
        if (!(Test-Path $Target)) {
            New-Item $Target -type directory
        }
        
        # Copy all logs files to target
        robocopy $LogFilePath $Target
        
        # Debug Info
        "Copied " + (Get-ChildItem ($LogFilePath)).Count + " items from " + $LogFilePath + " to " + $Target
    }
}