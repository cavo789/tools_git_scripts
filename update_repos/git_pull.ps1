# -----------------------------------------------------------------------
# This script will scan root folder (see the $repos array) and, in each
# of these folders, detect if the sub-folder is a git repository, 
# then run a git pull command to download the last version of the remote
# repository.
# When the sub-folder contains files locally modified, a warning will be
# displayed and the git pull command will not succeed.
# -----------------------------------------------------------------------

Clear-Host

# List of root folder of repositories, all sub-folders will be scanned
$repos = @(
    "C:\Christophe\Repository"
)

Write-Host "= Updating all repositories =`n"

foreach ($repo in $repos)
{
    Write-Host "    Processing root folder $repos`n" -ForegroundColor Cyan

    # Get the list of sub-folders
    $dir = Get-ChildItem $repos | Where-Object { $_.PSISContainer } | select-object FullName

    # And process one by one
    foreach ($d in $dir)
    {
        $dir = $d.FullName

        if (Test-Path "$dir\.git") {
            Write-Host "        Refresh $dir, run git pull -all"  -ForegroundColor Green

            # Go inside the working directory of the repo
            Set-Location $d.FullName

            # And pull it from the remote repository
            #    --all to update each branches
            #    --quiet don't show "Already up-to-date" i.e. unuseful text
            git pull --all --quiet
        }
    }
}

# Restore the current folder
Set-Location $PSScriptRoot;

Write-Host "Done"
