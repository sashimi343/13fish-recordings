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
require 'singleton'

class PathUtils
  include Singleton

  attr_reader :src_directory, :src_stylesheets, :src_javascript, :src_images, :cache_directory, :dst_directory, :dst_stylesheets, :dst_javascript, :dst_images

  def initialize
    @root = File.expand_path '../', File.dirname(__FILE__)
    @src_directory = File.expand_path 'src/', @root
    @src_stylesheets = File.expand_path 'assets/stylesheets/', @src_directory
    @src_javascript = File.expand_path 'assets/javascript/', @src_directory
    @src_images = File.expand_path 'assets/images/', @src_directory
    @cache_directory = File.expand_path 'tmp/', @root
    @dst_directory = File.expand_path 'public_html/', @root
    @dst_stylesheets = File.expand_path 'css/', @dst_directory
    @dst_javascript = File.expand_path 'js/', @dst_directory
    @dst_images = File.expand_path 'img/', @dst_directory
  end

  def absolutize_template(expression)
    expression += '.slim' unless expression.end_with? '.slim'
    File.expand_path "templates/#{expression}", @src_directory
  end

  def absolutize_resource(expression)
    expression += '.yml' unless expression.end_with? '.yml'
    File.expand_path "resources/#{expression}", @src_directory
  end

  def absolutize_partial(expression)
    expression += '.slim' unless expression.end_with? '.slim'
    File.expand_path "partials/#{expression}", @src_directory
  end

  def absolutize_html(path)
    if path.start_with? '/'
      File.expand_path path.sub('/', ''), @dst_directory
    else
      File.expand_path path, @dst_directory
    end
  end

  def absolutize_source_stylesheet(expression)
    File.expand_path expression, @src_stylesheets
  end

  def absolutize_dst_stylesheet(expression)
    File.expand_path expression, @dst_stylesheets
  end

  def to_cache(path)
    path.sub(@src_directory, @cache_directory) + '.cached'
  end
end
