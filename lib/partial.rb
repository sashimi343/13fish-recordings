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
class Partial
  def initialize(key, partial_name)
    @key = key
    @value = load_file partial_name
  end

  def reverse!
    @value.reverse! if @value and @value.instance_of? Array
  end

  def to_hash
    { key: @key, value: @value }
  end

  private

  def load_file(partial_name)
    paths = Dir.glob(File.expand_path("../src/partials/#{partial_name}", File.dirname(__FILE__)))
    case paths.size
    when 0
      raise RuntimeError.new "Unknown partial file: #{partial_name} (id = #{@id})"
    when 1
      renderer = Renderer.new
      renderer.render paths[0]
    else
      renderer = Renderer.new
      paths.map { |path| renderer.render path }
    end
  end
end
