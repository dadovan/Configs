function Global:Get-DirectoryShortcuts()
{
    [HashTable] $shortcuts =
    @{
        "home" = "$Env:USERPROFILE"
        "configs" = "$Env:USERPROFILE\git\configs"
    }
    return $shortcuts
}

<#
.SYNOPSIS
Changes the directory based on shortcut table.

.PARAMETER shortcut
The shortcut to change to.  Leave empty to show a list of all shortcuts.
#>
function Global:go ([String] $shortcut)
{
    [HashTable] $shortcuts = Get-DirectoryShortcuts
    if ($shortcut -ne "")
    {
        if ($shortcuts.Contains($shortcut))
        {
            Set-Location $shortcuts.$($shortcut)
            return
        }
        Write-Error "Shortcut $shortcut not defined"
    }
    Write-Host "Directory change shortcuts"
    $shortcuts.GetEnumerator() | Sort-Object Name | Format-Table -HideTableHeaders -AutoSize
}