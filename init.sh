#!/bin/bash
printf "Name of Project/Domain: "
read PROJECTNAME


# GIT
#git clone git@github.com:WordPress/WordPress.git $PROJECTNAME
#rm -rf ./$PROJECTNAME/.git

##############################
# Get files from wordpress.org
##############################
printf "*************************\n"
printf "*** Getting WordPress ***\n"
printf "*************************\n\n"

mkdir ./$PROJECTNAME
cd ./$PROJECTNAME
wget http://wordpress.org/latest.tar.gz
tar -zxf ./latest.tar.gz
mv ./wordpress/* ./
rm ./latest.tar.gz
rm -rf ./wordpress
cd ../

##############################
# Create Local WP files
##############################
printf "\nSetting up config files... "
cp ./base-files/local-config.php ./$PROJECTNAME/
cp ./base-files/wp-config.php ./$PROJECTNAME/

cd ./$PROJECTNAME
SECRETKEYS=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
EXISTINGKEYS='put your unique phrase here'
printf '%s\n' "g/$EXISTINGKEYS/d" a "$SECRETKEYS" . w | ed -s wp-config.php
printf "Done"
cd ../

##############################
# Setup Local Git Repo
##############################
printf "\nInitiate a git repo here? (y or n): "
read GITSETUP
if [ "$GITSETUP" = "y" ]; then
	cp ./base-files/gitignore.txt ./$PROJECTNAME/.gitignore
	cd ./$PROJECTNAME
	git init
	git add --all
	git commit -m "initial commit"
	git status
else
	printf "Skipping git setup."
fi


##############################
# Create Local Database
##############################


##############################
# Cleanup sky-base files
##############################


############
# todo
############
# populate local-config.php
# populate wp-config.php
# roots theme
# base plugins

printf "\nALL DONE!\n"
exit

rm -rf .git
cp -rf ./WordPress/* ./
rm -rf ./WordPress
cp -rf ./sky-base/local-config.php ./
cp -rf ./sky-base/utility-files/sync_uploads_to_local.sh ./
cp -rf ./sky-base/utility-files/sync_uploads_to_remote.sh ./
cp -rf ./sky-base/gitignore.txt ./.gitignore
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