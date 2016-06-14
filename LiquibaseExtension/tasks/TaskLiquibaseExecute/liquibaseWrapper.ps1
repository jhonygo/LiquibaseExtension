[CmdletBinding()]
param(
  [string]$changeLogFile,
  [string]$username,
  [string]$password,
  [string]$url,
  [string]$command,
  [string]$arguments
)

# For more information on the VSTS Task SDK:
try {
    # Set the working directory.
    #$cwd = Get-VstsInput -Name cwd -Require
    #Assert-VstsPath -LiteralPath $cwd -PathType Container
    #Write-Verbose "Setting working directory to '$cwd'."
    #Set-Location $cwd

    # Output the message to the log.
    Write-Host (Get-VstsInput -Name $username)
} finally {}
