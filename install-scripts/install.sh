#!/bin/bash

# Update package lists
sudo apt-get update >> /var/log/script.log 2>&1

# Install Apache2
sudo apt-get install -y apache2 >> /var/log/script.log 2>&1

# Create a default HTML page
echo '<!doctype html><html><body><h1>Hello from Terraform!</h1></body></html>' | sudo tee /var/www/html/index.html

# Restart Apache to apply changes
sudo systemctl restart apache2

echo "Script completed" >> /var/log/script.log