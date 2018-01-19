#/bin/bash

echo "Removing old static files from /var/www/html..."
rm -rf /var/www/html/*
echo "Removing local public files..."
rm -rf public/
echo "Running hugo..."
hugo
echo "Copying new static files to /var/www/html..."
cp -r public/* /var/www/html/.
echo "Rebuild Complete!"
