#
# Contain page information
# Copyright (C) 2016 sashimi All Rights Reserved.
#

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
end
