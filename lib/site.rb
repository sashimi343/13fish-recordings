#
# Load config/pages.rb and obtain site information
# Copyright (C) 2016 sashimi All Rights Reserved.
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
    self.instance_eval File.open(pages_file).read
    construct_page_tree
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
