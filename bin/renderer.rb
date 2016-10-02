#
# Render src/*.slim to public_html/*.html
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require 'slim'
require 'slim/include'
require 'fileutils'

class Renderer
  def initialize(root)
    @root = root
    @layout = src_path 'templates/layout'
  end

  #
  # Render src_file dst_file with template
  # @param src_file the source slim file (a possible relative path)
  # @param dst_file the path of the rendered HTML file (a possible relative path)
  # @param option values to be passed to the view
  #
  def render_with_template(src_file, dst_file, option = {})
    contents = render src_path(src_file), option
    page = apply_template contents, option
    write page, dst_path(dst_file)
  end

  #
  # Render src_file without template, and return rendered string
  # @param src_file the source slim file (a possible relative path)
  # @param option values to be passed to the view
  # @return rendered html string
  #
  def render(src_file, option = {})
    Slim::Template.new(src_path(src_file)).render(option)
  end

  private

  def src_path(src_file)
    src_file += ".slim" unless src_file.end_with? ".slim"
    File.absolute_path src_file, "#{@root}/src"
  end

  def dst_path(dst_file)
    dst_file += ".html" unless dst_file.end_with? ".html"
    File.absolute_path dst_file, "#{@root}/public_html"
  end

  def apply_template(contents, option)
    Slim::Template.new(@layout).render(option) { contents }
  end

  def write(blob, dst_path)
    dst_dir = File.dirname dst_path
    FileUtils.mkdir_p(dst_dir) unless FileTest.exist?(dst_dir)
    File.open(dst_path, 'w').write(blob)
  end
end
