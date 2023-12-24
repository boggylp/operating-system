# Precondition: Setup a git alias command git branch prune. See readme for more info.
param (
    [Parameter(Mandatory = $true)]
    $path)

$executingLocation = Get-Location
$depth = 0
$targetPath = Get-Item -Path $Path
$gitDirectories = Get-ChildItem -Directory -Path $targetPath -Depth $depth

foreach ($directory in $gitDirectories) {
    Write-Output $directory
    Set-Location $directory
    $ChangedFiles = $(git status --porcelain | Measure-Object | Select-Object -expand Count)
    if ($ChangedFiles -gt 0) {
        Write-Output "Found $ChangedFiles changed files. Skipping this repository."
        continue
    }
    git checkout master
    git fetch --prune origin
    git pull
    git branch-prune # this is a custom git command which requires setting up in gitconfig before running this script
    Set-Location $directory.Parent
}

Set-location $executingLocation