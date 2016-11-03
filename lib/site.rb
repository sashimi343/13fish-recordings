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
require_relative 'page_builder'
require_relative 'page'

class Site
  attr_reader :pages

  def initialize
    @pages = []
  end

  def load(pages_file)
    @pages = []
    self.instance_eval File.open(pages_file, 'r') { |file| file.read }
    construct_page_tree
    self
  end

  def self.load(pages_file)
    site = Site.new
    site.load pages_file
  end

  private

  def page(id, &block)
    page_builder = PageBuilder.new id
    page_builder.instance_eval &block
    @pages << page_builder.build
  end

  def construct_page_tree
    @pages.select { |page| page.parent.nil? }
      .map    { |root| { page: root, children: get_children_of(root) } }
      .each   { |root_node| set_children root_node }
  end

  def get_children_of(parent)
    @pages.select { |page| page.parent == parent.id }
          .map    { |page| { page: page, children: get_children_of(page) } }
  end

  def set_children(parent_node)
    parent = parent_node[:page]
    parent_node[:children].each do |child_node|
      child = child_node[:page]
      set_children child_node
      child.parent = parent unless child.parent.instance_of? Page
    end
  end
end
