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

# Index page
articles = Dir.glob("#{ROOT}/src/resources/articles/*").sort { |a, b| b <=> a }.map { |e| renderer.render e }
option = Option.create title: '13FISH Recordings', breadcrumbs: ["Index"], articles: articles
renderer.render_with_template 'contents/index', 'index', option

# About page
option = Option.create title: '13FISH Recordings', breadcrumbs: ["Index", "About"]
renderer.render_with_template 'contents/about', 'about', option
