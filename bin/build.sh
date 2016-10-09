#!/bin/sh

#
# Utility for converting slim files to html files
# and deploy it to test/production server
# 
# Copyright (C) 2016 sashimi All Rights Reserved.
#

root=`git rev-parse --show-toplevel`

if [ $? -ne 0 ]; then
    exit 1
fi

# Initialize current directory
cd ${root}

# Clear old files
rm -rf ${root}/public_html/*

# Render slim files
bundle exec ruby ./lib/slim_cms.rb ${root}

# Place static resources
cp -r ${root}/src/assets/stylesheets ${root}/public_html/css
cp -r ${root}/src/assets/images ${root}/public_html/img

if [ $# -eq 0 ]; then
    exit 0
fi

# Additional process
case $1 in
    "test")
        sudo cp -r ${root}/public_html/* /usr/share/nginx/html
        echo "finish deploying to test server (http://localhost:8192/)"
        ;;
    *)
        echo "Usage: ${root} [test]"
        exit 1
        ;;
esac
