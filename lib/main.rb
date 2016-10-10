#
# Define how to make HTML files from src/*.slim files
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require_relative 'site'

sitemap = Site.new
sitemap.load './config/pages.rb'

sitemap.pages.each { |page| page.render }
