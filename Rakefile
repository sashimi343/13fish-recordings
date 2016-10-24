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

DEST_DIR = "#{File.dirname __FILE__}/public_html"
DEST_CSS_DIR = "#{DEST_DIR}/css"
DEST_JS_DIR = "#{DEST_DIR}/js"
DEST_IMAGE_DIR = "#{DEST_DIR}/img"

directory DEST_CSS_DIR
directory DEST_JS_DIR
directory DEST_IMAGE_DIR

task 'default' => 'stage'

desc 'Build page contents, and upload it to STAGING server'
task 'stage' => ['build'] do
  sh "sudo cp -r #{DEST_DIR}/* /usr/share/nginx/html"
end

desc 'Build page contents'
task 'build' => ['init', 'update:html', 'update:css', 'update:js', 'update:image']

namespace :update do
  desc 'Update HTML files'
  task 'html' do
    sh 'bundle exec ruby ./lib/main.rb'
  end

  desc 'Update CSS files'
  task 'css' => DEST_CSS_DIR do
    sh "bundle exec sass --cache-location ./tmp/.sass-cache --style compressed ./src/assets/stylesheets/style.scss #{DEST_CSS_DIR}/style.css"
  end

  desc 'Update JavaScript files'
  task 'js' => DEST_JS_DIR do
    sh "cp -r ./src/assets/javascript/* #{DEST_JS_DIR}"
  end

  desc 'Update image files'
  task 'image' => DEST_IMAGE_DIR do
    sh "cp -r ./src/assets/images/* #{DEST_IMAGE_DIR}"
  end
end

desc "Cleanup #{DEST_DIR}"
task 'init' do
  sh "rm -rf #{DEST_DIR}/*"
end
