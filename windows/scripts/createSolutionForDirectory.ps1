param (
    [string]$Path = $PWD.Path
)

$currentDirectoryPath = Get-Item -Path $Path
$solutionName = "$(${currentDirectoryPath}.Name).sln"
$solutionPath = Join-Path -Path $currentDirectoryPath -ChildPath $solutionName

Write-Host "Directory being used: $currentDirectoryPath"
Write-Host "Solution name being used: $solutionName"
Write-Host "Full solution path: $solutionPath"

if (-Not (Test-Path -Path $solutionPath -PathType leaf)) {
    dotnet new sln --output $currentDirectoryPath
}

$csprojFiles = Get-ChildItem -Recurse -Path $currentDirectoryPath -Filter *.csproj -File | Resolve-Path -Relative
if ($csprojFiles.Count -gt 0) {
    foreach ($csproj in $csprojFiles) {
        dotnet sln $solutionPath add $csproj
    }
}

dotnet sln $solutionPath list
