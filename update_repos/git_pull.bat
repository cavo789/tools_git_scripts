CLS
@ECHO OFF
ECHO.
ECHO  =============================================
ECHO  = Updating repositories                     =
ECHO  = Christophe Avonture - aesecure.com        =
ECHO  = https://github.com/cavo789/github_scripts =
ECHO  =============================================

REM Retrieve any subfolders of the current one (folder where this script
REM has been stored and started) and call the process subroutine

FOR /f "delims=" %%D IN ('dir /a:d /b') DO (
    CALL :PROCESS %%~fD %%D
)

REM Now, process very specific subfolders : when the repo is in a subfolder like the ones below

FOR %%G IN (aesecure_Scan\aesecure-scanner, afuj\afuj) do ( 
   SET FOLDER=%%G
   CALL :GIT_PULL
)

GOTO END:

REM --------------------------------------------------------------------------------------

:PROCESS 

REM Parameters :
REM    %1  : full directory name (absolute); like C:\Christophe\repositories\aesecure
REM    %2  : directory name; like aesecure => name of the repository

IF EXIST %1\.git (

    REM The subfolder contains a .git folder => it's a repository
    REM %2 is the name of the repository 
    
    SET FOLDER=%2
    CALL :GIT_PULL
    
) 

GOTO :EOF

REM --------------------------------------------------------------------------------------

:GIT_PULL

ECHO.
ECHO  Updating %FOLDER%
PUSHD %FOLDER% >nul
git pull
POPD

GOTO :EOF

REM --------------------------------------------------------------------------------------

:END

exit /B
