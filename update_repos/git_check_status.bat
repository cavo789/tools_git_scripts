CLS
@ECHO OFF
ECHO.
ECHO  =============================================
ECHO  = Check if repositories have been changed   =
ECHO  = Christophe Avonture - avonture.be         =
ECHO  = https://github.com/cavo789/github_scripts =
ECHO  =============================================

REM Retrieve any subfolders of the current one (folder where this script
REM has been stored and started) and call the process subroutine

FOR /f "delims=" %%D IN ('dir /a:d /b') DO (
	CALL :PROCESS %%~fD %%D
)

GOTO END:

REM --------------------------------------------------------------------------------------

:PROCESS

REM Parameters :
REM	%1  : full directory name (absolute); like C:\Christophe\repositories\github_scripts
REM	%2  : directory name; like github_scripts => name of the repository

IF EXIST %1\.git (

	REM The subfolder contains a .git folder => it's a repository
	REM %2 is the name of the repository

	SET FOLDER=%2
	CALL :GIT_CHECK

)

GOTO :EOF

REM --------------------------------------------------------------------------------------

:GIT_CHECK

PUSHD %FOLDER% >nul

REM "git status --porcelain" returns the list of files that was changed
REM For instance
REM		M index.php
REM		M readme.md
REM
REM And FIND /v /c "" will count non empty lines (2 in the example above)

git status --porcelain | FIND /v /c "" > %TMP%\git-status

REM Get the number of files in the Count variable
SET /P Count= < %TMP%\git-status

REM If greater than zero, then we've local changes not yet commited
IF %Count% GTR 0 (
	ECHO The repo %FOLDER% should be updated; there are %Count% changes
)

DEL %TMP%\git-status
POPD

GOTO :EOF

REM --------------------------------------------------------------------------------------

:END

exit /B
