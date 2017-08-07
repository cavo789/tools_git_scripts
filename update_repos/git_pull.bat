CLS
@ECHO OFF
ECHO.
ECHO  =============================================
ECHO  = Updating repositories                     =
ECHO  = https://github.com/cavo789/github_scripts =
ECHO  =============================================

REM `Updating C:\MyRepositories\aesecure'
SET FOLDER=aesecure
CALL :GIT_PULL

REM `Updating C:\MyRepositories\joomla_free'
SET FOLDER=joomla_free
CALL :GIT_PULL

REM `Updating C:\MyRepositories\marknotes`
SET FOLDER=marknotes
CALL :GIT_PULL

REM `Updating C:\MyRepositories\winscp`
SET FOLDER=winscp
CALL :GIT_PULL

exit /B

REM -------------------------------------------------------

:GIT_PULL
ECHO.
ECHO  Updating %FOLDER%
PUSHD %FOLDER% >> NULL
git pull
POPD

:END
