# Git - Update repositories

Make a `git pull` i.e. update your git repos by taking the latest online version of your repositories.

The idea behind the script is to make a pull for severall repos, in a loop.

Consider the following situation : you've a `C:\MyRepositories\' folder where you've put a lot of repositories. You don't want (anymore) to make a `git pull` one by one, certainly since you've more than 5 repos.

So, just put a DOS batch like this one under the `C:\MyRepositories\' folder, call the script f.i. `Pull_Them.bat`. Once correctly parametrized, just fire the script and if everything goes fine... just enjoy ;-)

```
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
PUSHD %FOLDER% >> NULL
git pull
POPD

GOTO :EOF

REM --------------------------------------------------------------------------------------

:END

EXIT /B
```
