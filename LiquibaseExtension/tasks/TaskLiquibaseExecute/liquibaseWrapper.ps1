[CmdletBinding()]
param(
  # VARIABLES TAKEN FROM THE VSTS EXTENSION
  [string] [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $changeLogFile,
  [string] [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $dbms,
  [string] [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $username,
  [string] [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $password,
  [string] [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $hostname,
  [string] $port,
  [string] $dbname,  
  [string] $databaseOptions,
  [string] [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $command,   
  [string] $parameters,
  [string] $buildNumber = $env:BUILD_BUILDNUMBER,
  # CONSTANTS
  [string] $runtime = "liquibase.bat",
  [string] $driver = 'net.sourceforge.jtds.jdbc.Driver',
  # URL root
  [string] $url = "jdbc:jtds:${dbms}://${hostname}"
)

try {
    # Set JDBC URL with all optional parameters if any
    If ($port) { 
      $url = "${url}:${port}"
    }
    If ($dbname) { 
      $url = "${url}/${dbname}"
    }
    If ($databaseOptions) { 
      $url = "${url};${databaseOptions}"
    }

	# Define the full command to execute
	[string] $printableCommand = "--driver=$driver --url=$url --username=$username --password=XXXXXXXX $command $parameters"
	[string] $liquibaseCommand = "--driver=$driver --url=$url --username=$username --password=$password $command $parameters"
	
    Write "Executing $runtime $printableCommand"
    Start-Process -FilePath $runtime -ArgumentList $liquibaseCommand -Wait -passthru

} finally {}
