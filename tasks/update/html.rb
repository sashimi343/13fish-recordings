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
require_relative '../../lib/site'
require_relative '../../lib/path_utils'
require_relative '../../lib/renderer'

namespace :update do
  site = Site.load File.expand_path '../../config/pages.rb', File.dirname(__FILE__)
  path_utils = PathUtils.instance
  renderer = Renderer.new

  def get_dst_html_files(site)
    site.pages.map { |page| page.get_dst_absolute_path }
  end

  desc 'Update HTML files'
  task 'html' => get_dst_html_files(site)

  site.pages.each do |page|
    file page.get_dst_absolute_path => page.get_dependencies do
      page.render
    end
  end

  Dir.glob("#{path_utils.src_directory}/partials/**/*.slim").each do |src_path|
    cache_path = path_utils.to_cache src_path
    file cache_path => src_path do
      blob = renderer.render src_path
      cache_directory = File.dirname(cache_path)
      FileUtils.mkdir_p(cache_directory) unless FileTest.exist?(cache_directory)
      File.open(cache_path, 'w') { |file| file.puts blob }
    end
  end

end
