#!/bin/sh

#
# Convert slim files to html files
# Copyright (C) 2016 sashimi All Rights Reserved.
#

ROOT=`git rev-parse --show-toplevel`

ruby "${ROOT}/bin/recipe.rb" "${ROOT}"
