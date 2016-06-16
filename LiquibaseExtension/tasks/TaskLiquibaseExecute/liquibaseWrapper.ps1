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
  [string] $driver = "net.sourceforge.jtds.jdbc.Driver",
  # URL root
  [string] $url = "jdbc:jtds:${dbms}://${hostname}"
)

try {
    # Set JDBC URL with all optional parameters if any
    If (-Not $port) { 
      $url = "${url}:${port}"
    }
    If (-Not $dbname) { 
      $url = "${url}/${dbname}"
    }
    If (-Not $databaseOptions) { 
      $url = "${url};${databaseOptions}"
    }

    Write "Executing $runtime --driver=$driver --url=$url --username=$username --password=XXXXXXXX $command $parameters" 
    $A = Start-Process -FilePath "$runtime" --driver="$driver" --url="$url" --username="$username" --password="$password" "$command" "$parameters" -Wait -passthru;$a.ExitCode

} finally {}
