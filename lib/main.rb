#
# Define how to make HTML files from src/*.slim files
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require_relative 'site'

site = Site.new
site.load File.expand_path '../config/pages.rb', File.dirname(__FILE__)

site.pages.each { |page| page.render }
