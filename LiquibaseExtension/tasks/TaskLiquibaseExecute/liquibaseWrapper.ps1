[CmdletBinding()]
param(
  # VARIABLES TAKEN FROM THE VSTS EXTENSION
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $changeLogFile,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $dbms,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $username,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $password,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $hostname,
  [string] $port,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $dbname,  
  [string]$databaseOptions,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $command,   
  [string]$parameters,
  [string]$buildNumber = $env:BUILD_BUILDNUMBER,
  # CONSTANTS
  [string]$runtime = "liquibase.bat"
  [string]$driver = "lib/jtds-1.3.1.jar"
)

try {
    # Set the working directory.
    #$cwd = Get-VstsInput -Name $=cwd -Require
    #Assert-VstsPath -LiteralPath $cwd -PathType Container
    #Write-Verbose "Setting working directory to '$cwd'."
    #Set-Location $cwd
    url='TODO CONSTRUCT URL DBMS/HOSTNAME(/PORT)(/DATABASEOPTIONS)'
    
    Write "Executing '$runtime' --driver='$driver' --url='$url' --username='$username' --password='XXXXXXXX' '$command' '$parameters' " 
    $A = Start-Process -FilePath '$runtime' --driver='$driver' --url='$url' --username='$username' --password='$password' '$command' '$parameters' -Wait -passthru;$a.ExitCode

} finally {}
