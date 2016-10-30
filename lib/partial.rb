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
require_relative 'renderer'
require_relative 'path_utils'

class Partial
  attr_reader :key, :paths

  def initialize(key, expression, desc)
    @key = key
    paths = expand_glob expression
    @paths = desc ? paths.reverse : paths
  end

  def load
    @paths.zip(cached_paths).map { |src_path, cached_path| load_partial src_path, cached_path }
  end

  def cached_paths
    path_utils = PathUtils.instance
    @paths.map { |path| path_utils.to_cache path }
  end

  private

  def expand_glob(expression)
    Dir.glob PathUtils.instance.absolutize_partial expression
  end

  def load_partial(src_path, cached_path)
    if FileTest.exist? cached_path
      File.open(cached_path).read
    elsif FileTest.exist? src_path
      renderer = Renderer.new
      blob = renderer.render src_path
      cached_directory = File.dirname(cached_path)
      FileUtils.mkdir_p(cached_directory) unless FileTest.exist?(cached_directory)
      File.open(cache_path, 'w').write(blob)
      blob
    else
      raise RuntimeError.new "Unknown partial file: #{src_path}"
    end
  end
end
