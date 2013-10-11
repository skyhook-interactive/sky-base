sky-base
=================

Contributors: corycrowley, bigwilliam, kyletheisen, joshnichols, mattbob

Roll a new WordPress installation.

1. Download the repo `git clone git@github.com:skyhook-marketing/sky-base.git`
1. Run /sky-base/init.sh in Terminal `sky-base/init.sh`
1. Answer the prompts.

> I decided to combine the most common, repetitive steps of the process into one useful bash script that:

> 1. Downloads WordPress from GitHub
> 1. Creates a new database (and lets me name it) and gives the MySQL user proper permissions
> 1. Generates my <a href="http://codex.wordpress.org/Editing_wp-config.php#Security_Keys" target="_blank">security keys</a> and adds them to `wp-config.php`
> 1. Adds my database name, username, and password to `local-config.php`

FAQ
-----------------

Getting _fatal: could not create work tree dir..._ or having other permissions-related issues? Put `sudo` in front of the path to the script before running it.