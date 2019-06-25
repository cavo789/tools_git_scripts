# Git - Update and check if changes not committed

> Provide easy batch scripts for working with repo and Windows

## Table of Contents

- [git_check_status](#git_check_status)
- [git_get_origin](#git_get_origin)
- [git_pull](#git_pull)
- [Author](#author)
- [License](#license)

## git_check_status

This file works like the previous one but will scan all your folders and will detect if you've local repository with modified files not yet committed.

This batch will produce an output like :

```
=============================================
= Check if repositories have been changed   =
= Christophe Avonture - avonture.be         =
= https://github.com/cavo789/github_scripts =
=============================================
The repo aesecure-firewall should be updated; there are 1 changes
The repo marknotes should be updated; there are 4 changes
The repo marknotes.wiki should be updated; there are 2 changes
The repo ms_access should be updated; there are 1 changes
The repo sql_sp_columns should be updated; there are 1 changes
The repo ssis_export_flatfiles_spec should be updated; there are 1 changes
The repo vbaExcelRibbonDropdown should be updated; there are 1 changes
```

And then you know which repo should be committed.

## git_get_origin

Loop any sub-folders and display the origin of each repos.

This batch will produce an output like :

```
 =============================================
 = Display the origin of repositories        =
 = Christophe Avonture - avonture.be         =
 = https://github.com/cavo789/github_scripts =
 =============================================
https://bitbucket.org/cavo789/xxxxxxxxxx
https://bitbucket.org/cavo789/yyyyyyyyyy
https://github.com/cavo789/aaaaaaaa.git
https://github.com/cavo789/bbbbbbbb.git
https://github.com/cavo789/cccccccc.git
```

So, it's easy to determine where you've stored each repositories.

## git_pull

Make a `git pull` i.e. update your git repos by taking the latest online version of your repositories.

The idea behind the script is to make a pull for several repos, in a loop.

Consider the following situation : you've a `C:\MyRepositories\' folder where you've put a lot of repositories. You don't want (anymore) to make a`git pull` one by one, certainly since you've more than 5 repos.

So, just put a DOS batch like this one under the `C:\MyRepositories\' folder, call the script f.i.`Pull_Them.bat`. Once correctly parametrized, just fire the script and if everything goes fine... just enjoy ;-)

## Author

AVONTURE Christophe

## License

[MIT](LICENSE)
