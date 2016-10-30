#
# MIT License
#
# Copyright (c) 2016 sashimi
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
require 'slim'
require 'fileutils'
require_relative 'path_utils'

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

  LAYOUT = PathUtils.instance.absolutize_template '_layout'

  def apply_template(contents, option)
    Slim::Template.new(LAYOUT).render(option) { contents }
  end

  def write(blob, dst_path)
    dst_dir = File.dirname dst_path
    FileUtils.mkdir_p(dst_dir) unless FileTest.exist?(dst_dir)
    File.open(dst_path, 'w') { |file| file.puts blob }
  end
end
