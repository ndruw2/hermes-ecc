#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$UpstreamUrl    = 'https://github.com/affaan-m/ECC.git'
$UpstreamBranch = 'main'

$remotes = git remote
if ($remotes -notcontains 'upstream') {
    Write-Host "[hermes-sync] adding upstream remote -> $UpstreamUrl"
    git remote add upstream $UpstreamUrl
}

Write-Host "[hermes-sync] fetching upstream/$UpstreamBranch"
git fetch upstream $UpstreamBranch
if ($LASTEXITCODE -ne 0) { throw "git fetch failed" }

$currentBranch = (git branch --show-current).Trim()
Write-Host "[hermes-sync] merging upstream/$UpstreamBranch into $currentBranch"
git merge "upstream/$UpstreamBranch" @args
if ($LASTEXITCODE -ne 0) { throw "git merge failed (resolve conflicts, then commit)" }

Write-Host "[hermes-sync] done. Re-run .\install.ps1 to apply updates to %USERPROFILE%\.claude\"
