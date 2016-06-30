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
  [string] $parameters,
  [string] [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $command,   
  [string] $commandOptions,
  [string] $buildNumber = $env:BUILD_BUILDNUMBER,
  # CONSTANTS
  [string] $runtime = "runtime\liquibase.bat",
  [string] $driver = 'net.sourceforge.jtds.jdbc.Driver',
  # URL root
  [string] $url = "jdbc:jtds:${dbms}://${hostname}"
)

#try {
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
	[string] $printableCommand = "--driver=$driver --url=$url --username=$username --password=$password --changeLogFile=$changeLogFile $parameters $command $commandOptions"
	$liquibaseCommand = @("--driver=$driver", "--url=$url", "--username=$username", "--password=$password", "--changeLogFile=$changeLogFile", "$parameters", "$command", "$commandOptions")
	
    	Write-Host "Executing $runtime $printableCommand"
    	#Start-Process -FilePath $runtime -ArgumentList $liquibaseCommand -Wait -passthru
	$cmdOutput = & $runtime $liquibaseCommand 2>&1
		
	if($Lastexitcode -eq 0) {
		$cmdOutput | where {$_.gettype().Name -ne "ErrorRecord"} | foreach {
			Write-Host "$_"
		}
	}
	else {
		$cmdOutput = $cmdOutput | where {$_.gettype().Name -eq "ErrorRecord"}
		Write-Error "$cmdOutput"
	}

#} finally {}
