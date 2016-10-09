#
# Define how to make HTML files from src/*.slim files
# @param ROOT the Git root directory
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require "./lib/sitemap"
require './lib/renderer'
require './lib/option'

# Get command line arguments
$root = ARGV[0]

def get_breadcrumbs(page)
  breadcrumbs = [{ title: page.title }]

  page = page.parent
  while page
    breadcrumbs.unshift ({ title: page.title, path: page.path })
    page = page.parent
  end

  breadcrumbs
end

sitemap = Sitemap.new
sitemap.load "./config/pages.rb"

renderer = Renderer.new

sitemap.pages.each do |page|
  breadcrumbs = get_breadcrumbs page
  params = {
    title: page.title,
    breadcrumbs: get_breadcrumbs(page)
  }
  params.merge! page.resources
  params.merge! page.partials
  option = Option.create params
  renderer.render_with_template "./src/templates/#{page.template}.slim", "./public_html#{page.path}", option
end
