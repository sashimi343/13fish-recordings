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
require_relative 'resource'
require_relative 'partial'

class PageBuilder
  def initialize(id)
    @id = id
    @parent = nil
    @title = ''
    @path = ''
    @template = ''
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
    @resources.push Resource.new key, resource_name
  end

  def partial(key, expression, desc = false)
    @partials.push Partial.new key, expression, desc
  end

  def build
    Page.new @id, @parent, @title, @path, @template, @resources, @partials
  end
end
