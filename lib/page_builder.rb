#
# Build page instance
# Copyright (C) 2016 sashimi All Rights Reserved.
#

require 'yaml'
require_relative 'renderer'
require_relative 'resource'
require_relative 'partial'

class PageBuilder
  def initialize(id)
    @id = id
    @parent = nil
    @title = @path = @template = ''
    @resources = []
    @partials = []
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
    resource = Resource.new key, resource_name
    @resources << resource.to_hash
  end

  def partial(key, partial_name, desc = false)
    partial = Partial.new key, partial_name
    partial.reverse! if desc
    @partials << partial.to_hash
  end

  def build
    Page.new @id, @parent, @title, @path, @template, @resources, @partials
  end
end
