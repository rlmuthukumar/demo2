#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
echo "<h1>Welcome to My Page Muthukumar </h1>" | sudo tee /var/www/html/index.html
