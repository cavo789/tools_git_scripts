@echo off

cls

setlocal EnableDelayedExpansion

ECHO.
ECHO  =============================================
ECHO  = Check if repositories have been changed   =
ECHO  = Christophe Avonture - avonture.be         =
ECHO  = https://github.com/cavo789/github_scripts =
ECHO  =============================================
ECHO.

FOR /f "delims=" %%D IN ('dir /a:d /b') DO (
    CALL :fnProcessFolder %%~fD %%D
)

ECHO [32mDone, all folders have been processed.[0m

GOTO END:

::--------------------------------------------------------
::-- fnProcessFolder -
::      %1 = full name of the folder that should be processed
::           f.i. "C:\Christophe\Repository\Repo1"
::      %2 = basename of the folder
::           f.i. "Repo1"
::--------------------------------------------------------
:fnProcessFolder

SET folder=%1

:: Check if the folder is a repo (i.e. has the .git sub-folder)
IF EXIST %folder%\.git (
    ECHO  Process %folder%
    ECHO.

    ::Go inside that folder
    PUSHD %folder% >nul

    :: Commit changes to the repository
    CALL :fnCheckStatus

    ::Return in the original folder
    POPD

)

GOTO:EOF

::--------------------------------------------------------
::-- fnCheckStatus - If needed, commit changes to the repo
::      %1 = name of the folder that should be processed
::--------------------------------------------------------
:fnCheckStatus

REM "git status --porcelain" returns the list of files that was changed
REM For instance
REM     M index.php
REM     M readme.md
REM
REM And FIND /v /c "" will count non empty lines (2 in the example above)

git status --porcelain | FIND /v /c "" > %TMP%\git-status

REM Get the number of files in the Count variable
SET /P Count= < %TMP%\git-status

REM If greater than zero, then we've local changes not yet commited
IF %Count% GTR 0 (
    ECHO    [43m------------------------------------[0m
    ECHO    [43m- Warning: Uncommitted files found -[0m
    ECHO    [43m------------------------------------[0m
    ECHO.
) ELSE (
    ECHO     [32mThere is no local changes for the repo[0m
    ECHO.
)

DEL %TMP%\git-status

GOTO:EOF

::--------------------------------------------------------
::-- This is the end
::--------------------------------------------------------
:END
endlocal
