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
require_relative 'renderer'
require_relative 'option_builder'

class Page
  attr_reader :id, :title, :path, :template, :resources, :partials
  attr_accessor :parent

  def initialize(id, parent, title, path, template, resources, partials)
    @id = id
    @parent = parent
    @title = title
    @path = path
    @template = template
    @resources = resources
    @partials = partials
  end

  def render
    renderer = Renderer.new
    src_path = File.expand_path "../src/templates/#{@template}.slim", File.dirname(__FILE__)
    dst_path = File.expand_path "../public_html#{@path}", File.dirname(__FILE__)
    option = build_option
    renderer.render_with_template src_path, dst_path, option
  end

  private

  def build_option
    option_builder = OptionBuilder.new
    option_builder.set_title @title
    option_builder.set_resources @resources
    option_builder.set_partials @partials
    option_builder.set_breadcrumbs self
    option_builder.build
  end
end
