#!/bin/bash

# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

# Update package information and upgrade installed packages
sudo apt update -y
sudo apt upgrade -y

# Install Apache web server
sudo apt install -y apache2

# Enable and start Apache service
sudo systemctl enable apache2
sudo systemctl start apache2

# Create the main index.html page
sudo echo '<h1>Welcome to Donnettech Technologies</h1>' | sudo tee /var/www/html/index.html

# Create a directory for your app
sudo mkdir /var/www/html/app1

# Create an index.html page for your app
sudo tee /var/www/html/app1/index.html <<EOF
<!DOCTYPE html>
<html>
<body style="background-color:rgb(250, 210, 210);">
<h1>Welcome to Donnettech Technologies</h1>
<p>Terraform Demo</p>
<p>Application Version: V1</p>
</body>
</html>
EOF

# Download instance metadata
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html
