$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$appDir = Join-Path $toolsDir 'Diver'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $appDir
  url64bit       = 'https://github.com/usediver/homebrew-diver/releases/download/v1.0.1-478/Diver-1.0.1-478-windows-x64.zip'
  checksum64     = 'bd0bab2cf457b6bc0247f080070e7a0e0cc5515174034a916e094d7ebc4669f8'
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# The shim Chocolatey puts on the PATH starts Diver and returns, rather than
# holding a console open for as long as the window is.
New-Item -ItemType File -Force -Path (Join-Path $appDir 'Diver.exe.gui') | Out-Null

$programs = [Environment]::GetFolderPath('CommonPrograms')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Diver.lnk') `
  -TargetPath (Join-Path $appDir 'Diver.exe') -WorkingDirectory $appDir
