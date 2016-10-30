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
require 'ostruct'
require_relative 'page'

class OptionBuilder
  def initialize
    @option = {}
  end

  def set_title(title)
    @option[:title] = title
  end

  def set_resources(resources)
    resources.each { |resource| set_if_absent resource.key, resource.load }
  end

  def set_partials(partials)
    partials.each { |partial| set_if_absent partial.key, partial.load }
  end

  def set_breadcrumbs(page)
    @option[:breadcrumbs] = get_breadcrumbs page
  end

  def build
    OpenStruct.new @option
  end

  private

  Keywords = %w(title breadcrumbs)

  def set_if_absent(key, value)
    if @option.has_key? key.to_sym or Keywords.include? key
      raise RuntimeError.new "Duplicated key: #{key}"
    else
      @option[key.to_sym] = value
    end
  end

  def get_breadcrumbs(leaf_page)
    breadcrumbs = [{ 'title' => leaf_page.title }]

    page = leaf_page.parent
    while page
      breadcrumbs.unshift({ 'title' => page.title, 'path' => page.path })
      page = page.parent
    end

    breadcrumbs
  end
end
