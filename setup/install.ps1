#Requires -Version 5.1
<#
.SYNOPSIS
    Installe la skill product-orchestrator au niveau utilisateur (~/.copilot/skills/).

.DESCRIPTION
    Copie setup/user-skills/product-orchestrator/ vers le repertoire des skills
    utilisateur de GitHub Copilot. Idempotent : ecrase toujours la copie existante,
    pas de fusion. A relancer apres tout `git pull` qui modifie setup/user-skills/.
#>

$ErrorActionPreference = "Stop"

$sourceDir = Join-Path $PSScriptRoot "user-skills\product-orchestrator"
$targetDir = Join-Path $env:USERPROFILE ".copilot\skills\product-orchestrator"

if (-not (Test-Path $sourceDir)) {
    Write-Error "Source introuvable : $sourceDir"
    exit 1
}

if (Test-Path $targetDir) {
    Remove-Item -Path $targetDir -Recurse -Force
}

New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
Copy-Item -Path (Join-Path $sourceDir "*") -Destination $targetDir -Recurse -Force

Write-Host "Skill product-orchestrator installee : $targetDir" -ForegroundColor Green
