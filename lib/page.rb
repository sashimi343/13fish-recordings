#
# Contain page information
# Copyright (C) 2016 sashimi All Rights Reserved.
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
