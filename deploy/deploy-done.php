<?php

// OPTIONAL SCRIPT. Here, in this example, once the deploy has been done,
// this script will kill the gulp folder, the dist folder and will copy every files
// of the src folder in the parent folder then kill the src folder.
//
// Place here any "post commands" you wish to fire when the repository has been updated.

require_once('deploy-config.php');

if ($_GET) {
    $sat = isset($_GET['sat'])?$_GET['sat']:'';
} else {
    // Script started on the command line
   $sat = $argv[1];
}


if ($sat !== SECRET_ACCESS_TOKEN) {
    header($_SERVER['SERVER_PROTOCOL'] . ' 403 Forbidden', true, 403);
    die('<h2>ACCESS DENIED!</h2>');
}

/**
 * Copy a file, or recursively copy a folder and its contents
 * @author      Aidan Lister <aidan@php.net>
 * @version     1.0.1
 * @link        http://aidanlister.com/2004/04/recursively-copying-directories-in-php/
 * @param       string   $source    Source path
 * @param       string   $dest      Destination path
 * @param       int      $permissions New folder creation permissions
 * @return      bool     Returns true on success, false on failure
 */
function xcopy($source, $dest, $permissions = 0755)
{

   // Check for symlinks
   if (is_link($source)) {
       return symlink(readlink($source), $dest);
   }

   // Simple copy for a file
   if (is_file($source)) {
       return copy($source, $dest);
   }

   // Make destination directory
   if (!is_dir($dest)) {
       mkdir($dest, $permissions);
   }

   // Loop through the folder
   $dir = dir($source);
    while (false !== $entry = $dir->read()) {
        // Skip pointers
      if ($entry == '.' || $entry == '..') {
          continue;
      }
      // Deep copy directories
      xcopy("$source/$entry", "$dest/$entry", $permissions);
    }

   // Clean up
   $dir->close();
    return true;
} // function xcopy()

if (is_dir($folder = TARGET_DIR.'gulp')) {
    shell_exec('rm -rf '.$folder);
}
if (is_dir($folder = TARGET_DIR.'dist')) {
    shell_exec('rm -rf '.$folder);
}

if (is_dir($folder = TARGET_DIR.'src')) {
    xcopy($folder, TARGET_DIR);
    shell_exec('rm -rf '.$folder);
}
