ps-log-collector
================

*This is under active development and not a finished product.*

Introduction
------------
A Powershell project that collects IIS logs. The mechanism will be as follows:

* Identify log directories with corresponding IIS sites
* Get all log files to a location under folders that are named for site name
* Remove all logs older than `X` days from server

Usage
-----

This script will be used as follows:

    .\log-collector.ps1 <OutputDirectory> [<SourceDirectory>]

Where `OutputDirectory` is the path to save the logs in, and the optional `SourceDirectory` is where the logs currently as saved, which defaults to `C:\inetpub\logs\LogFiles`. 

Example
-------
Consider an IIS configuration as follows:

    Name             ID   State      Physical Path                    Bindings                                                       
    ----             --   -----      -------------                    --------
    web1.mysite.com  7    Started    C:\inetpub\wwwroot\MySite\Web1   http *:80:web1.mysite.com

The log file for this website will be stored by default in this location:

    C:\inetpub\logs\LogFiles\W3SVC7\u_ex130316.log
    C:\inetpub\logs\LogFiles\W3SVC7\u_ex130317.log
    C:\inetpub\logs\LogFiles\W3SVC7\u_ex130318.log

Where the number following `W3SVC` is the site's `ID` and the numbers following `u_ex` are the date of the log in the form `YYMMDD`.

Running this command:

    .\log-collector.ps1 E:\MyLogs

Will result in the creation of the directory `E:\MyLogs\web1.mysite.com` (if it doesn't already exist), and it will be populated with contents of `C:\inetpub\logs\LogFiles\W3SVC7`. This gives us cleaner access to logs, since the logic for associating sites with their IIS ID's is decoupled, and the output can now be used for any independent analysis. Furthermore, this can be used to store the logs in a large offline data store, and the server can be routinely cleaned of old logs.

TODO
----

* <del>Find out how to map site ID's to site names</del>
* Find an rsync equivalent in Powershell for copying
* Find out how this can be scheduled / run remotely
* Make it configurable and give more command line options, such as delete logs after `X` days
