#
# Render src/*.slim to public_html/*.html
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require 'slim'
require 'fileutils'

class Renderer
  def initialize(root)
    @root = root
    @layout = src_path 'templates/layout'
  end

  #
  # Render src_file dst_file with template
  # @param src_file the source slim file
  # @param dst_file the path of the rendered HTML file
  # @param option values to be passed to the view
  #
  def render_with_template(src_file, dst_file, option = {})
    contents = render src_path(src_file), option
    page = apply_template contents, option
    write page, dst_path(dst_file)
  end

  private

  def src_path(src_file)
    "#{@root}/src/#{src_file}.slim"
  end

  def dst_path(dst_file)
    "#{@root}/public_html/#{dst_file}.html"
  end

  def render(src_path, option)
    Slim::Template.new(src_path).render(option)
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
