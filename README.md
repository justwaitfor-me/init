# GitHub Repository Initialization PowerShell Script

This PowerShell script is designed to set up a new GitHub repository with a standardized directory structure, initialize Git, and create essential files from templates (e.g., `README.md`, `LICENSE`, `.gitignore`, and `.env.example`). This setup provides a clean, professional base for a project, making it easier to develop, deploy, and maintain.

## Table of Contents

- [Features](#features)
- [Files Created by the Script](#files-created-by-the-script)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [How to Use the Script](#how-to-use-the-script)
  - [Parameters](#parameters)
  - [Running the Script](#running-the-script)
- [Directory Structure](#directory-structure)
- [Template Placeholders](#template-placeholders)
- [Making Changes After Setup](#making-changes-after-setup)
- [Notes](#notes)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Features

- **Git Initialization**: Initializes a Git repository and creates essential branches (`main`, `develop`, `feature/template`, and `bugfix/template`).
- **Directory Structure Creation**: Automatically creates directories like `src`, `tests`, `config`, `docs`, `.github/workflows`, and `scripts`.
- **Template-Based File Creation**: Populates key files from templates, replacing placeholders with user-defined values.
- **GitHub Actions Workflow**: Sets up a basic GitHub Actions CI/CD workflow.

## Files Created by the Script

- **README.md**: A project description file, created from a template with placeholders replaced by actual values.
- **LICENSE**: A license file based on the selected license type, with placeholders for the year and author.
- **.gitignore**: A basic `.gitignore` file, created from a template.
- **.env.example**: An example environment variables file for reference.

## Prerequisites

- **PowerShell**: Make sure you have PowerShell installed.
- **Git**: This script requires Git to initialize the repository and create branches. Git should be installed and accessible in your system's PATH.

## Getting Started

1. Clone this repository:

    ```bash
    git clone https://github.com/justwaitfor-me/init.git
    ```

2. Navigate to the cloned repository:

    ```bash
    cd init
    ```

3. Ensure the following template files are present in the repository directory:
   - `README.template.md`
   - `LICENSE.template`
   - `.gitignore.template`
   - `.env.example.template`

4. (Optional) Update the placeholders in the template files if needed (e.g., `{{ProjectName}}`, `{{Author}}`, etc.).

## How to Use the Script

### Parameters

The script accepts the following parameters:

- `ProjectName`: The name of your project (default is `"MeinProjekt"`).
- `Author`: The name of the project's author (default is `"Dein Name"`).

### Running the Script

1. Open PowerShell and navigate to the directory containing the `.ps1` file.
2. Run the script with the following command:

    ```powershell
    .\initialize-repo.ps1 -ProjectName "YourProjectName" -Author "Your Name" 
    ```

3. After running, a new folder with the specified project name will be created, and the repository will be initialized inside this folder.

## Directory Structure

The script creates the following structure:

YourProjectName/ ├── .github/ │ └── workflows/ │ └── ci.yml # Basic GitHub Actions workflow ├── config/ # Configuration files ├── docs/ # Documentation files ├── src/ # Main source code directory ├── tests/ # Directory for test files ├── scripts/ # Additional automation scripts ├── README.md # Project description ├── LICENSE # License file ├── .gitignore # Git ignore file └── .env.example # Example environment file

## Template Placeholders

The script replaces placeholders in the template files with actual values provided via parameters. Here are some commonly used placeholders:

- `{{ProjectName}}`: Replaced with the project name.
- `{{Author}}`: Replaced with the author's name.
- `{{Year}}`: Replaced with the current year.

## Making Changes After Setup

- **Edit README.md**: Update the `README.md` file to include detailed information about your specific project, such as setup instructions, usage examples, and dependencies.
- **License Customization**: If you want a different license than MIT or Apache-2.0, you can either update the `LICENSE.template` file or manually adjust the `LICENSE` file after creation.
- **GitHub Actions Workflow**: The default `ci.yml` workflow is set up for Node.js projects. Modify this file if you’re using a different environment, adding steps specific to your project’s build and test needs.
- **Add More Template Files**: If you want additional template files, create them in the same directory and adjust the script to include them.

## Notes

- **Custom Template Files**: This script relies on template files stored in the same directory as the script. Make sure to include all required templates (`README.template.md`, `LICENSE.template`, etc.) in this directory before running the script.
- **Modifying the Script**: You can customize this script further by adding additional functions or template files as required by your project.

## Troubleshooting

- **Git Not Found**: Ensure that Git is installed and added to your system’s PATH.
- **PowerShell Permission Issues**: If PowerShell prevents the script from running, you may need to change the execution policy:

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force
    ```

## License

This script itself is open-source and free to use under the MIT License. See `LICENSE` for more details.
