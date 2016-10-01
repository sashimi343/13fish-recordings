#
# Define how to make HTML files from src/*.slim files
# @param ROOT the Git root directory
# Copyright (C) 2016 sashimi All Rights Reserved.
#

# Get command line arguments
ROOT = ARGV[0]

require "#{ROOT}/bin/renderer"
require "#{ROOT}/bin/option"

renderer = Renderer.new ROOT

# sample page
option = Option.create title: '13FISH Recordings', name: 'aaaaa'
renderer.render_with_template 'sample.slim', 'hoge/sample.html', option
