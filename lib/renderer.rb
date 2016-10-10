#
# Render src/*.slim to public_html/*.html
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require 'slim'
require 'fileutils'

class Renderer
  #
  # Render src_path dst_path with template
  # @param src_path the source slim file
  # @param dst_path the path of the rendered HTML file
  # @param option values to be passed to the view
  #
  def render_with_template(src_path, dst_path, option = {})
    contents = render src_path, option
    page = apply_template contents, option
    write page, dst_path
  end

  #
  # Render src_path without template, and return rendered string
  # @param src_path the source slim file
  # @param option values to be passed to the view
  # @return rendered html string
  #
  def render(src_path, option = {})
    Slim::Template.new(src_path).render(option)
  end

  private

  LAYOUT = './src/templates/_layout.slim'

  def apply_template(contents, option)
    Slim::Template.new(LAYOUT).render(option) { contents }
  end

  def write(blob, dst_path)
    dst_dir = File.dirname dst_path
    FileUtils.mkdir_p(dst_dir) unless FileTest.exist?(dst_dir)
    File.open(dst_path, 'w').write(blob)
  end
end
