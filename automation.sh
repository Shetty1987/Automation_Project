#!/bin/bash

sudo apt update -y

#check apache2 server is installed or not
#if not then install the server

httpd --version
if [ $? -gt 0 ]
then
	#install the apche2 server
	sudo apt install apache2	
fi

# check apache2 server is running or not
#if not, then start the server

ps cax | grep httpd
if [ $? -eq 0 ]
 then
	 echo "apache server is running"
else 
	 echo "apache server is not running."
	 sudo systemctl start apache2
fi


#enable the service
sudo systemctl enable apache2

#variables
timestamp=$(date '+%d%m%Y-%H%M%S')
echo "time stamp - $timestamp"
myname="guruprasad"
s3_bucket="upgrad-guruprasad"

#create the archive file
tar -cvf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/ 

#upload the tar file to AWS S3 bucket
aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar


#get the size of the file
size=$(ls -lh /tmp/${myname}-httpd-logs-${timestamp}.tar | cut -d " " -f 5)

#check  /var/www/html/inventory.html file exists or not

test -e /var/www/html/inventory.html
if [ $? -gt 0 ]
then
	touch /var/www/html/inventory.html
        echo "Log Type	Time Created	Type	Size" > /var/www/html/inventory.html	
fi

# append job  info to  inventory.html
echo "httpd-logs"	 $timestamp	 "tar"	 $size >>  /var/www/html/inventory.html
