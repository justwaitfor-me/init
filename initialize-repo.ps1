# PowerShell-Skript zur Initialisierung und Strukturierung eines GitHub-Repos mit Templates
param (
    [string]$ProjectName = "MeinProjekt",
    [string]$Author = "Dein Name"
)

function Initialize-GitRepository {
    param (
        [string]$RepoPath
    )
    Write-Output "Initialisiere Git-Repository im Verzeichnis $RepoPath"
    Set-Location -Path $RepoPath
    git init
    git branch -M main
    git add .
    git commit -m "Initial commit"
    
    # Optionale Branches erstellen
    git branch develop
    git branch feature/template
    git branch bugfix/template
    git checkout main

    Write-Output "Repository initialisiert und Branches erstellt."
}

function Create-ProjectStructure {
    param (
        [string]$RepoPath,
        [string]$Author,
        [string]$ProjectName
    )

    # Projektverzeichnis erstellen
    if (!(Test-Path -Path $RepoPath)) {
        New-Item -ItemType Directory -Path $RepoPath
    }

    # Ordnerstruktur
    $folders = @("src", "tests", "config", "docs", ".github/workflows", "scripts")
    foreach ($folder in $folders) {
        New-Item -ItemType Directory -Path "$RepoPath/$folder" -Force
    }
    
    # Template-Verzeichnis ermitteln
    $scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

    # Dateien aus Templates erstellen
    Copy-TemplateFile -TemplatePath "$scriptDir/README.template.md" -DestinationPath "$RepoPath/README.md" -Placeholders @{ ProjectName = $ProjectName; Author = $Author }
    Copy-TemplateFile -TemplatePath "$scriptDir/LICENSE.template" -DestinationPath "$RepoPath/LICENSE" -Placeholders @{ Author = $Author; Year = (Get-Date -Year).Year }
    Copy-TemplateFile -TemplatePath "$scriptDir/.gitignore.template" -DestinationPath "$RepoPath/.gitignore"
    Copy-TemplateFile -TemplatePath "$scriptDir/.env.example.template" -DestinationPath "$RepoPath/.env.example"

    # GitHub Actions Workflow-Template erstellen
    $workflowContent = @"
name: CI/CD Pipeline

on:
  push:
    branches:
      - main
      - develop
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v2
      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'
      - run: npm install
      - run: npm test
"@
    Set-Content -Path "$RepoPath/.github/workflows/ci.yml" -Value $workflowContent

    Write-Output "Projektstruktur und Templates erstellt."
}

function Copy-TemplateFile {
    param (
        [string]$TemplatePath,
        [string]$DestinationPath,
        [hashtable]$Placeholders = @{}
    )

    if (Test-Path -Path $TemplatePath) {
        # Template-Inhalt lesen
        $content = Get-Content -Path $TemplatePath -Raw

        # Platzhalter ersetzen
        foreach ($key in $Placeholders.Keys) {
            $content = $content -replace "\{\{$key\}\}", $Placeholders[$key]
        }

        # Inhalt in die Zieldatei schreiben
        Set-Content -Path $DestinationPath -Value $content
        Write-Output "Datei $DestinationPath wurde aus Template $TemplatePath erstellt."
    }
    else {
        Write-Output "Template-Datei $TemplatePath nicht gefunden."
    }
}

# Hauptskript
$repoPath = "$PSScriptRoot/$ProjectName"
Create-ProjectStructure -RepoPath $repoPath -Author $Author -ProjectName $ProjectName
Initialize-GitRepository -RepoPath $repoPath
Write-Output "Projekt $ProjectName wurde erfolgreich erstellt und initialisiert."
