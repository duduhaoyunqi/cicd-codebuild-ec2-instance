#!/bin/bash
sudo su
yum update -y
yum install -y httpd wget unzip
sed -i '/^Listen 80/cListen 9999' /etc/httpd/conf/httpd.conf
cd /var/www/html
wget https://www.free-css.com/assets/files/free-css-templates/download/page295/sbs.zip
unzip sbs.zip
cp -r sbs-html/* /var/www/html/
rm -rf sbs-html sbs.zip
systemctl enable httpd 
systemctl start httpd
