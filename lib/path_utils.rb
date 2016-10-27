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

  def initialize
    @root = File.expand_path '../', File.dirname(__FILE__)
    @source_directory = File.expand_path 'src/', @root
    @cache_directory = File.expand_path 'tmp/', @root
    @dest_directory = File.expand_path 'public_html/', @root
    @dest_stylesheets = File.expand_path 'css/', @dest_directory
    @dest_javascript = File.expand_path 'js/', @dest_directory
    @dest_images = File.expand_path 'img/', @dest_directory
  end

  def absolutize_template(expression)
    expression += '.slim' unless expression.end_with? '.slim'
    File.expand_path "templates/#{expression}", @source_directory
  end

  def absolutize_resource(expression)
    expression += '.yml' unless expression.end_with? '.yml'
    File.expand_path "resources/#{expression}", @source_directory
  end

  def absolutize_partial(expression)
    expression += '.slim' unless expression.end_with? '.slim'
    File.expand_path "partials/#{expression}", @source_directory
  end

  def absolutize_html(path)
    path.slice! 0 if path.start_with? '/'
    File.expand_path path, @dest_directory
  end

  def absolutize_source_stylesheet(expression)
    File.expand_path "assets/stylesheets/#{expression}", @source_directory
  end

  def absolutize_dest_stylesheet(expression)
    File.expand_path expression, @dest_stylesheets
  end

  def to_cache(path)
    path.sub @source_directory, @cache_directory
  end

  def get_source_stylesheets_directory
    File.expand_path 'assets/stylesheets/', @source_directory
  end

  def get_source_javascripts_directory
    File.expand_path 'assets/javascript', @source_directory
  end

  def get_source_images_directory
    File.expand_path 'assets/images', @source_directory
  end

  def get_dest_html_directory
    @dest_directory
  end

  def get_dest_stylesheet_directory
    @dest_stylesheets
  end

  def get_dest_javascript_directory
    @dest_javascript
  end

  def get_dest_image_directory
    @dest_images
  end
end
