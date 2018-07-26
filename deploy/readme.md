# Simple PHP Git deploy script

> https://github.com/markomarkovic/simple-php-git-deploy/

Developed by [Marko Marković](https://github.com/markomarkovic)

This script will make life so easy... This utility will allow developers to update a website based on a git repository by just running a URL that will start a `git pull` i.e. by getting the newer version of the repository.

- If your website is fully hosted on a git or a portion of this site, change your repo and start the script; the site will be updated.
- If your website is a demo site of a git project, update the repo and start the script, the site will be refreshed very fast.

## Configuration

To do just once.

Just copy `deploy.php` and `deploy-config.php` to your root folder, on your FTP server. Put them in the folder where you've the copy of the repository.

Edit the `deploy-config.php` file and look for

- `SECRET_ACCESS_TOKEN` : type a very long key, of your own. Be original. Let's say 'MyVeryLongSecretPassword-JustMine',
- `REMOTE_REPOSITORY` : mention there you repo URL,
- `TARGET_DIR` : set your folder, where your website is located.

## Use it

Now, to run the script, just run `deploy.php?sat=deploy.php?sat=MyVeryLongSecretPassword-JustMine` from the URL.
