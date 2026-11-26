$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$appDir = Join-Path $toolsDir 'Diver'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $appDir
  url64bit       = 'https://github.com/usediver/homebrew-diver/releases/download/v1.0.1-530/Diver-1.0.1-530-windows-x64.zip'
  checksum64     = '7b01731521fcf7f6a330833298cbc62aee72f83928c74d20ca822de4f011c762'
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# The shim Chocolatey puts on the PATH starts Diver and returns, rather than
# holding a console open for as long as the window is.
New-Item -ItemType File -Force -Path (Join-Path $appDir 'Diver.exe.gui') | Out-Null

$programs = [Environment]::GetFolderPath('CommonPrograms')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Diver.lnk') `
  -TargetPath (Join-Path $appDir 'Diver.exe') -WorkingDirectory $appDir
