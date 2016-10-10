#
# Define how to make HTML files from src/*.slim files
# @param ROOT the Git root directory
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require_relative 'sitemap'

# Get command line arguments
$root = ARGV[0]

sitemap = Sitemap.new
sitemap.load './config/pages.rb'

sitemap.pages.each { |page| page.render }
