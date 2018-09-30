Set-StrictMode -Version Latest

# ---- Local Functions --------------------------------------------------------

# Turn ConEmu's taskbar icon green
function Global:Notify-ConEmu()
{
    Write-Host -NoNewline "50%`r"
    Write-Host -NoNewline "100% "
}

# ---- Execute ----------------------------------------------------------------

New-PSDrive -Name OneDrive -PSProvider FileSystem -Root "$Env:USERPROFILE\OneDrive" -Scope Global | Out-Null
New-PSDrive -Name Git -PSProvider FileSystem -Root "$Env:USERPROFILE\git" -Scope Global | Out-Null
& Git:\Configs\Windows\Scripts\Set-Prompt.ps1
& Git:\Configs\Windows\Scripts\Set-DirectoryShortcuts.ps1