#!/bin/bash
sudo su
yum update -y
yum install -y httpd wget
sed -i '/^Listen 80/cListen 9999' /etc/httpd/conf/httpd.conf
cd /var/www/html
wget https://github.com/azeezsalu/jupiter/archive/refs/heads/main.zip
unzip main.zip
cp -r jupiter-main/* /var/www/html/
rm -rf jupiter-main main.zip
systemctl enable httpd
systemctl start httpd
