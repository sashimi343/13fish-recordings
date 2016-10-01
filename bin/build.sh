#!/bin/sh

#
# Convert slim files to html files
# Copyright (C) 2016 sashimi All Rights Reserved.
#

GIT_DIR=`git rev-parse --show-toplevel`
SRC="${GIT_DIR}/src"
PUBLIC_HTML="${GIT_DIR}/public_html"

bundle exec slimrb -p "${SRC}/sample.slim" >"${PUBLIC_HTML}/sample.html"
