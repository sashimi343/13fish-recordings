#
# Build page instance
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require 'yaml'
require './lib/renderer'

class PageBuilder
  def initialize(id)
    @id = id
    @parent = nil
    @title = @path = @template = ''
    @resources = @partials = {}
  end

  def parent(parent = nil)
    @parent = parent
  end

  def title(title = '')
    @title = title
  end

  def path(path = '')
    @path = path
  end

  def template(template = '')
    @template = template
  end

  def resource(key, resource_name)
    resource = load_resource resource_name
    if @resources.key? key or @partials.key? key
      raise RuntimeError.new "Duplicated resource key: #{key} (id = #{@id})"
    else
      @resources[key] = resource
    end
  end

  def partial(key, partial_name, desc = false)
    partial = if desc
                load_partial_desc partial_name
              else
                load_partial partial_name
              end
    if @resources.key? key or @partials.key? key
      raise RuntimeError.new "Duplicated partial key: #{key} (id = #{@id})"
    else
      @partials[key] = partial
    end
  end

  def build
    Page.new @id, @parent, @title, @path, @template, @resources, @partials
  end

  private

  def load_resource(resource_name)
    path = "./src/resources/#{resource_name}.yml"
    if File.exist? path
      YAML.load_file path
    else
      raise RuntimeError.new "Unknown resource file: #{resource_name} (id = #{@id})"
    end
  end

  def load_partial(partial_name)
    paths = Dir.glob "./src/partials/#{partial_name}"
    case paths.size
    when 0
      raise RuntimeError.new "Unknown partial file: #{partial_name} (id = #{@id})"
    when 1
      YAML.load_file paths[0]
    else
      renderer = Renderer.new
      paths.map { |path| renderer.render path }
    end
  end

  def load_partial_desc(partial_name)
    paths = Dir.glob "./src/partials/#{partial_name}"
    case paths.size
    when 0
      raise RuntimeError.new "Unknown partial file: #{partial_name} (id = #{@id})"
    when 1
      YAML.load_file paths[0]
    else
      renderer = Renderer.new
      paths.reverse.map { |path| renderer.render path }
    end
  end
end
