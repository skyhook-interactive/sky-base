#!/bin/bash
git clone git@github.com:WordPress/WordPress.git
rm -rf .git
cp -rf ./WordPress/* ./
rm -rf ./WordPress
cp -rf ./sky-base/local-config.php ./
cp -rf ./sky-base/utility-files/sync_uploads_to_local.sh ./
cp -rf ./sky-base/utility-files/sync_uploads_to_remote.sh ./
cp -rf ./sky-base/.gitignore ./
cp -rf ./sky-base/wp-config.php ./
rm -rf ./wp-config-sample.php
printf "MySQL User: "
read MYSQLUSER
if [ "$MYSQLUSER" = "" ]; then
	set MYSQLUSER = "root"
fi
printf "MySQL Password: "
read MYSQLPWD
printf "What would you like to name your new database (i.e. newwpdb)? "
read NEWDB
echo "CREATE DATABASE $NEWDB; GRANT ALL ON $NEWDB.* TO '$MYSQLUSER'@'localhost';" | /Applications/MAMP/Library/bin/mysql -u$MYSQLUSER -p$MYSQLPWD
printf "Live MySQL User: "
read LIVEMYSQLUSER
if [ "$LIVEMYSQLUSER" = "" ]; then
	set LIVEMYSQLUSER = "live_username_here"
fi
printf "Live MySQL Password: "
read LIVEMYSQLPWD
if [ "$LIVEMYSQLPWD" = "" ]; then
	set LIVEMYSQLPWD = "live_password_here"
fi
printf "Live database name? "
read LIVEMYSQLDBNAME
if [ "$LIVEMYSQLDBNAME" = "" ]; then
	set LIVEMYSQLDBNAME = "live_database_name_here"
fi
SECRETKEYS=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
EXISTINGKEYS='put your unique phrase here'
printf '%s\n' "g/$EXISTINGKEYS/d" a "$SECRETKEYS" . w | ed -s wp-config.php
DBUSER=$"username_here"
DBPASS=$"password_here"
DBNAME=$"database_name_here"
sed -i '' -e "s/${DBUSER}/${MYSQLUSER}/g" local-config.php
sed -i '' -e "s/${DBPASS}/${MYSQLPWD}/g" local-config.php
sed -i '' -e "s/${DBNAME}/${NEWDB}/g" local-config.php
LIVEDBUSER=$"live_username_here"
LIVEDBPASS=$"live_password_here"
LIVEDBNAME=$"live_database_name_here"
sed -i '' -e "s/${LIVEDBUSER}/${LIVEMYSQLUSER}/g" wp-config.php
sed -i '' -e "s/${LIVEDBPASS}/${LIVEMYSQLPWD}/g" wp-config.php
sed -i '' -e "s/${LIVEDBNAME}/${LIVEMYSQLDBNAME}/g" wp-config.php
mkdir ./wp-content/uploads/