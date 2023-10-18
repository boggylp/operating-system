param (
    [Parameter(Mandatory = $true)]
    $path)

$depth = 1
$gitDirectories = Get-ChildItem -Directory -Path ($path * $depth);

foreach ($directory in $gitDirectories) {
    Write-Output $directory
    Set-Location $directory.Name
    git pull
    Set-Location $directory.Parent
}