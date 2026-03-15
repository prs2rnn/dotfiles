# Variables
$repositoryFolder = "~/Documents/My Notes 2026"
$remoteRepo = "git@github.com:prs2rnn/notes.git"
$commitMessage = "Backup on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# Functions
function Execute-Command {
    param (
        [string]$command
    )
    Write-Host "Executing: $command"
    Invoke-Expression $command
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error executing command: $command" -ForegroundColor Red
        throw "Error executing command: $command"
    }
}

try {
    # Check if repository folder exists
    if (-Not (Test-Path -Path $repositoryFolder)) {
        Write-Host "Cloning repository..."
        Execute-Command "git clone $remoteRepo $repositoryFolder"
    }

    # Change directory to repository folder
    Set-Location -Path $repositoryFolder

    # Add changes to git
    Write-Host "Adding changes to git..."
    Execute-Command "git add ."

    # Commit changes
    Write-Host "Committing changes..."
    Execute-Command "git commit -m `"$commitMessage`""

    # Push changes to remote repository
    Write-Host "Pushing changes to remote repository..."
    Execute-Command "git push"

    # Script end
    Write-Host "Backup completed successfully!" -ForegroundColor Green
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
} finally {
    # Prevent console from closing
    Read-Host -Prompt "Press Enter to exit"
}
