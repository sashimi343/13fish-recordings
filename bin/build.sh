#!/bin/sh

#
# Convert slim files to html files
# Copyright (C) 2016 sashimi All Rights Reserved.
#

ROOT=`git rev-parse --show-toplevel`

# Clear old files
rm -rf "${ROOT}/public_html/*"

# Render slim files
ruby "${ROOT}/bin/recipe.rb" "${ROOT}"

# Place static resources
cp -r "${ROOT}/src/assets/stylesheets" "${ROOT}/public_html/css"
cp -r "${ROOT}/src/assets/images" "${ROOT}/public_html/img"
