CLS
@ECHO OFF
ECHO.
ECHO  =============================================
ECHO  = Updating repositories                     =
ECHO  = https://github.com/cavo789/github_scripts =
ECHO  =============================================

for %%G in (aesecure, git_scripts, joomla_free, markdown, notes, winscp) do (
   SET FOLDER=%%G
   CALL :GIT_PULL
)

exit /B

REM -------------------------------------------------------

:GIT_PULL
ECHO.
ECHO  Updating %FOLDER%
PUSHD %FOLDER% >> NULL
git pull
POPD
