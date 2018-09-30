<#
.SYNOPSIS
Global prompt override method
#>
function Global:Prompt
{
    $currentBranch = $null
    git branch --no-color | % { if ($_ -match "^\* (.*)") { $currentBranch = $matches[1] } }

    $fancySpacerSymbol = [Char]::ConvertFromUtf32(0xE0B0)
    $initialFC = $host.ui.RawUI.ForegroundColor
    $initialBC = $host.ui.RawUI.BackgroundColor

    $id = 1
    $historyItem = Get-History -Count 1
    if($historyItem)
    {
       $id = $historyItem.Id + 1
    }
    $paths = Get-Location -Stack
    if ($paths.Count -ne 0)
    {
        $pathsArray = $paths.ToArray()
        [Int32] $width = 0
        for ($i = 0; $i -le ($paths.Count - 1); $i ++)
        {
            if ($pathsArray[$i].Path.Length -gt $width)
            {
                $width = $pathsArray[$i].Path.Length
            }
        }
        for ($i = 0; $i -le ($paths.Count - 1); $i ++)
        {
            [String] $line = [System.String]::Format((" {0,-" + $width + "} "), $pathsArray[$i])
            Write-Host -NoNewline "  "
            $fc = $initialBC
            $bc = [System.ConsoleColor]::Cyan
            Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc $fancySpacerSymbol
            $fc = [System.ConsoleColor]::Black
            Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc $line
            $fc = $bc
            $bc = $initialBC
            Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc $fancySpacerSymbol
            Write-Host ""
        }
    }

    $fc = [System.ConsoleColor]::White
    $bc = [System.ConsoleColor]::Blue
    Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc "#$id"
    $fc = $bc
    $bc = [System.ConsoleColor]::Gray
    Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc $fancySpacerSymbol

    if ($currentBranch -ne $null) { Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc " [$($currentBranch)] @" }
    Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc " $(Get-Location) "
    $fc = $bc
    $bc = $initialBC
    Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc $fancySpacerSymbol
    $fc = [System.ConsoleColor]::DarkGray
    Write-Host -NoNewline -ForegroundColor $fc -BackgroundColor $bc " "
    return " `b"
}
