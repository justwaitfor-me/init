param (
    [string]$ProjectName = "MeinProjekt",
    [string]$Author = "Dein Name"
)

# Template URLs
$TemplateUrls = @{
    "README.md"           = "https://raw.githubusercontent.com/justwaitfor-me/init/refs/heads/main/README.template.md"
    "LICENSE"             = "https://raw.githubusercontent.com/justwaitfor-me/init/refs/heads/main/LICENSE.template"
    ".gitignore"          = "https://raw.githubusercontent.com/justwaitfor-me/init/refs/heads/main/.gitignore.template"
    ".env.example"        = "https://raw.githubusercontent.com/justwaitfor-me/init/refs/heads/main/.env.example.template"
    ".vscode\launch.json" = "https://raw.githubusercontent.com/justwaitfor-me/init/refs/heads/main/.vscode/launch.json"
}

# Initialize Git repository
function Init-GitRepo {
    $repoPath = "$PSScriptRoot\..\$ProjectName" # Place in parent directory
    Set-Location -Path $repoPath
    if (-not (Test-Path ".git")) {
        git init
        git branch -M main
        git add . 
        git commit -m "Initial commit"
        "Branches created." | Write-Output
    }
    else { "Git repository already initialized." | Write-Output }
    
    # Create branches if not exist
    "develop", "feature/template", "bugfix/template" | ForEach-Object {
        if (-not (git branch --list $_)) { git branch $_; "$_ branch created." | Write-Output }
    }
    git checkout main
}

# Create project structure and download templates
function Create-Project {
    $repoPath = "$PSScriptRoot\..\$ProjectName" # Place in parent directory
    if (-not (Test-Path $repoPath)) { New-Item -ItemType Directory -Path $repoPath }
    "src", "tests", "config", "docs", "scripts", ".vscode" | ForEach-Object { New-Item -ItemType Directory -Path "$repoPath\$_" -Force }

    # Download template files
    $TemplateUrls.GetEnumerator() | ForEach-Object { 
        $filePath = "$repoPath\$($_.Key)"
        $folderPath = Split-Path -Path $filePath -Parent
        if (-not (Test-Path $folderPath)) { New-Item -ItemType Directory -Path $folderPath -Force }
        
        Invoke-WebRequest -Uri $_.Value -OutFile $filePath 
        "$($_.Key) downloaded." | Write-Output
    }
}

# Main
Create-Project
Init-GitRepo
"Project $ProjectName initialized." | Write-Output
