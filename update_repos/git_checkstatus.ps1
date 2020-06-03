Clear-Host

Write-Host ""
Write-Host "  ============================================"
Write-Host "  = Check if repositories have been changed  ="
Write-Host "  = Christophe Avonture - avonture.be        ="
Write-Host "  = https://github.com/cavo789/github_scripts="
Write-Host "  ============================================"
Write-Host ""

$currentDir = "$(Get-Location)\"

# Change -Depth value to go deeper in the folder tree
# -Depth 0 is for first level sub-folders
$dir = $(
    Get-ChildItem -Path $currentDir -Directory `
    -Depth 0 -Force -ErrorAction SilentlyContinue
) | Select-Object FullName

$counter = 1

foreach($file in $dir) {

    $repository = $file.FullName 

    if (Test-Path -Path "$repository\.git" -PathType Container) {

        # It's a git folder, go inside the folder
        Push-Location $repository

        # Check if there are uncommited changes in the folder
        $countFiles = $(git status --porcelain | Measure-Object | Select-Object -expand Count)

        if ($countFiles -gt 0) {
            Write-Output "  $counter. There are $countFiles changed files in $repository"
            $counter += 1
        }

        Pop-Location
    }
}

Write-Host "`nDone, all folders have been processed." -ForegroundColor Green
