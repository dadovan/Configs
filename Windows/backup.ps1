function BackupFile([string] $app, [string] $file)
{
    [string] $appPath = "Software\$app"
    if (-not (Test-Path $appPath)) { mkdir $appPath }
    Copy-Item $file $appPath
}

. BackupFile SumatraPDF "$Env:USERPROFILE\AppData\Roaming\SumatraPDF\SumatraPDF-settings.txt"
. BackupFile VSCode "$Env:USERPROFILE\AppData\Roaming\Code\User\settings.json"
Copy-Item "$Env:USERPROFILE\OneDrive\PowerShell\Profile.ps1" Scripts