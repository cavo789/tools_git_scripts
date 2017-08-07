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
```
