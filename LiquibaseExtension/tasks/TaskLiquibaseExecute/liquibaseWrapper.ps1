[CmdletBinding()]
param(
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $driver,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $changeLogFile,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $username,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $password,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $url,
  [string][Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] $command,   
  [string]$parameters,
  [string]$buildNumber = $env:BUILD_BUILDNUMBER,
  [string]$runtime = "liquibase.bat"
)

try {

    # Set the working directory.
    #$cwd = Get-VstsInput -Name cwd -Require
    #Assert-VstsPath -LiteralPath $cwd -PathType Container
    #Write-Verbose "Setting working directory to '$cwd'."
    #Set-Location $cwd
	Write "Executing '$runtime' --driver='$driver' --url='$url' --username='$username' --password='XXXXXXXX' '$command' '$parameters' " 
	$A = Start-Process -FilePath '$runtime' --driver='$driver' --url='$url' --username='$username' --password='$password' '$command' '$parameters' -Wait -passthru;$a.ExitCode

} finally {}
