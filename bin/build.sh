#!/bin/sh
#
# MIT License
#
# Copyright (c) 2016 sashimi
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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
bundle exec ruby ./lib/main.rb

# Compile SCSS files
mkdir ${root}/public_html/css
bundle exec sass --cache-location tmp/.sass-cache --style compressed ${root}/src/assets/stylesheets/style.scss ${root}/public_html/css/style.css

# Place static resources
#cp -r ${root}/src/assets/stylesheets ${root}/public_html/css
cp -r ${root}/src/assets/images ${root}/public_html/img
cp -r ${root}/src/assets/javascript ${root}/public_html/js

# Prevent displaying index of directory
find ${root}/public_html -type d -exec touch {}/index.html \;

# Change permissions
find ${root}/public_html -type d -exec chmod 755 {} \;
find ${root}/public_html -type f -exec chmod 644 {} \;

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
