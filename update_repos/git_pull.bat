@ECHO OFF

CLS

SETLOCAL EnableDelayedExpansion

ECHO.
ECHO  ====================================================
ECHO  = Check if local copy of repositories needs to be  =
ECHO  = refreshed. This can be done only when no local   =
ECHO  = changes have been made.                          =
ECHO  = Christophe Avonture - avonture.be                =
ECHO  = https://github.com/cavo789/github_scripts        =
ECHO  ====================================================

ECHO.
ECHO  [32mScanning your repositories...[0m

REM Retrieve any subfolders of the current one (folder where this script
REM has been stored and started) and call the process subroutine

FOR /f "delims=" %%D IN ('dir /a:d /b') DO (
    CALL :PROCESS %%~fD %%D
)

GOTO END:

REM --------------------------------------------------------------------------------------

:PROCESS

    REM Parameters :
    REM	%1: full directory name (absolute); like C:\Christophe\repositories\github_scripts
    REM	%2: directory name; like github_scripts => name of the repository

    IF EXIST %1\.git (

        REM The subfolder contains a .git folder => it's a repository
        REM %2 is the name of the repository

        SET FOLDER=%1

        CALL :GIT_CHECK !FOLDER!

    )

GOTO :EOF

:GIT_CHECK

    SET FOLDER=%1

    PUSHD %FOLDER% >nul

    REM "git status --porcelain" returns the list of files that was changed
    REM And FIND /v /c "" will count non empty lines (2 in the example above)
    git status --porcelain | FIND /v /c "" > %TMP%\git-status

    REM Get the number of files in the Count variable
    SET /P Count= < %TMP%\git-status

    REM If equal to zero, no local changes have been made
    REM Check with git remote update if the local repository is up-to-date
    REM or not
    IF %Count% EQU 0 (

        git remote update >NUL

        git status > %TMP%\git-status

        REM Findstr will return 0 when the pattern has been found
        findstr /C:"Your branch is behind" %TMP%\git-status >NUL

        IF !ERRORLEVEL! EQU 0 (
            ECHO  [32m%FOLDER% need a refresh, a newer version is available; use `git pull`[0m

            CHOICE /N /C:YNC /M "Press Y to refresh the repository, N for No or C for Cancel."

            REM Third choice = cancel => quit
            IF ERRORLEVEL ==3 (
                GOTO:END
            ) 

            REM Second choice = no => do nothing
            IF ERRORLEVEL ==2 (
                REM Do nothing
            ) ELSE (
                REM First choice = yes => refresh
                IF ERRORLEVEL ==1 (
                    REM Get the latest version of the repository
                    git pull
                )
            )

        ) ELSE (
            ECHO  [37m%FOLDER% is up-to-date[0m
        )

    ) ELSE (

        ECHO  [37m%FOLDER% is up-to-date[0m

    )

    DEL %TMP%\git-status

    POPD

GOTO :EOF

:END

    ENDLOCAl 

    exit /B

