param(
    [string]$Target = "."
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Dest = Join-Path $Target ".claude/agents"

New-Item -ItemType Directory -Force -Path $Dest | Out-Null
Copy-Item -Path (Join-Path $ScriptDir ".claude/agents/*.md") -Destination $Dest -Force

Write-Host "Telepitve: $Dest"
Write-Host "Ne felejtsd el commitolni es pusholni a celprojektben, hogy telefonon es Remote Controllal is mukodjon."
