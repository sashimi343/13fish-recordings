#
# Define how to make HTML files from src/*.slim files
# @param ROOT the Git root directory
# Copyright (C) 2016 sashimi All Rights Reserved.
#

# Get command line arguments
ROOT = ARGV[0]

require "#{ROOT}/lib/renderer"
require "#{ROOT}/lib/option"

renderer = Renderer.new ROOT

# Index page
articles = Dir.glob("#{ROOT}/src/partials/articles/*").sort { |a, b| b <=> a }.map { |e| renderer.render e }
option = Option.create title: '13FISH Recordings', breadcrumbs: ["Index"], articles: articles
renderer.render_with_template 'index', 'index', option

# About page
option = Option.create title: '13FISH Recordings', breadcrumbs: ["Index", "About"]
renderer.render_with_template 'about', 'about', option
