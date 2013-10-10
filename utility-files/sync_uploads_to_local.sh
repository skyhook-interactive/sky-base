#!/bin/sh

printf "Enter the ftp user to sync uploads? "
read FTP_USERNAME

printf "Enter the host? "
read HOST

rsync -avz -e ssh --progress $FTP_USERNAME@$HOST:/home/$FTP_USERNAME/public_html/wp-content/uploads/. ./wp-content/uploads/