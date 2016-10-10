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
    option = build_option
    renderer.render_with_template "./src/templates/#{@template}.slim", "./public_html#{@path}", option
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
