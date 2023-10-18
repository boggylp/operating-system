param (
     [Parameter(Mandatory)]
     [string]$PersonalAccessToken,
     [string]$Path = $PWD.Path,
     [string]$Project,
     [string]$Organization
)

$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PersonalAccessToken)"))
$headers = @{Authorization = ("Basic {0}" -f $base64AuthInfo) }

$result = Invoke-RestMethod -Uri "https://dev.azure.com/$organization/$Project/_apis/git/repositories?api-version=6.0" -Method Get -Headers $headers
if ($null -eq $result.value.name) {
     Write-Error "Failed to get repositories information. Check if your input is valid.";
     return
}

$targetPath = Get-Item -Path $Path
Write-Host "Using target path: $targetPath"
$executionLocation = Get-Location;
Set-Location $targetPath
$result.value.name | ForEach-Object {
     git clone ("https://$organization@dev.azure.com/$organization/$Project/_git/" + [uri]::EscapeDataString($_))
}
Set-Location $executionLocation