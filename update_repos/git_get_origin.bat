CLS
@ECHO OFF
ECHO.
ECHO  =============================================
ECHO  = Display the origin of repositories        =
ECHO  = Christophe Avonture - avonture.be         =
ECHO  = https://github.com/cavo789/github_scripts =
ECHO  =============================================

ECHO.
ECHO Info: to change the origin of a repo, you can use the following statement:
ECHO git remote set-url origin url_to_new_repo
ECHO.

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

REM ECHO Check status for %2

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

REM Run the "git remote ..." command and redirect to output to the ORIGIN variable
FOR /f %%i IN ('git remote get-url origin') do set ORIGIN=%%i
ECHO %FOLDER% is linked to %ORIGIN%

POPD

GOTO :EOF

REM --------------------------------------------------------------------------------------

:END

exit /B
