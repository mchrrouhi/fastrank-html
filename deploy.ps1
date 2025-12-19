# Fastrank.io Deployment Script to Hostinger via SSH
# Usage: .\deploy.ps1

$RemoteHost = "u118534042@185.201.10.97"
$RemotePath = "~/domains/fastrank.io/public_html"
$LocalPath = "$PSScriptRoot"

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Fastrank.io SSH Deployment" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Connecting to Hostinger..." -ForegroundColor Yellow

# Step 1: Backup remote files
Write-Host "Creating backup on server..." -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
ssh $RemoteHost "cd $RemotePath && tar -czf backup-$timestamp.tar.gz --exclude=.git --exclude=archive ."

# Step 2: Deploy using scp
Write-Host "Uploading new files..." -ForegroundColor Green

# Function to copy files recursively
function Copy-FilesViaSSH {
    param(
        [string]$LocalDir,
        [string]$RemoteDir,
        [string[]]$Exclude = @(".git", "archive", "node_modules", ".vscode", "pnpm-lock.yaml", ".env")
    )
    
    Get-ChildItem -Path $LocalDir -Force | ForEach-Object {
        $itemName = $_.Name
        $isExcluded = $Exclude -contains $itemName
        
        if (-not $isExcluded) {
            if ($_.PSIsContainer) {
                Write-Host "  Creating directory: $itemName" -ForegroundColor Gray
                ssh $RemoteHost "mkdir -p $RemoteDir/$itemName"
                Copy-FilesViaSSH -LocalDir $_.FullName -RemoteDir "$RemoteDir/$itemName" -Exclude $Exclude
            } else {
                Write-Host "  Uploading: $itemName" -ForegroundColor Cyan
                scp -p "$($_.FullName)" "${RemoteHost}:$RemoteDir/$itemName" 2>$null
            }
        }
    }
}

# Start deployment
Copy-FilesViaSSH -LocalDir $LocalPath -RemoteDir $RemotePath

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "Deployment Complete!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Verifying deployment..." -ForegroundColor Yellow
ssh $RemoteHost "ls -la $RemotePath | head -20"
