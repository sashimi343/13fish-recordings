#
# Render src/*.slim to public_html/*.html
# @param ROOT the Git ROOT directory
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require 'slim'
require 'json'

# Get command line arguments
ROOT = ARGV[0]

#
# Render src_file dst_file with layout
# @param src_file the source slim file
# @param dst_file the path of the rendered HTML file
# @param scope 
#
def render_with_template(src_file, dst_file, scope = {})
  contents_string = File.open("#{ROOT}/src/#{src_file}").read
  contents = Slim::Template.new { contents_string }.render(scope)
  layout_string = File.open("#{ROOT}/src/templates/layout.slim").read
  layout = Slim::Template.new { layout_string }
  page = layout.render(scope) { contents }
  File.open("#{ROOT}/public_html/#{dst_file}", 'w').write(page)
end

# sample page
option = { title: '13FISH Recordings', name: 'aaaaa' }
scope = JSON.parse option.to_json, object_class: OpenStruct
render_with_template 'sample.slim', 'sample.html', scope
