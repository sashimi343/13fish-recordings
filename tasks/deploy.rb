#
# MIT License
#
# Copyright (c) 2017 sashimi
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
require 'yaml'
require_relative '../lib/ftp_uploader'

desc 'Build page contents, and upload it to the server'
#task 'deploy' => ['build'] do
task 'deploy' do
  ftp_config = YAML.load_file File.expand_path '../config/ftp.yml', File.dirname(__FILE__)
  ftp_uploader = FTPUploader.new(
    ftp_config['server'],
    ftp_config['user'],
    ftp_config['password'],
    File.expand_path('../public_html', File.dirname(__FILE__)),
    ftp_config['remote_dir']
  )
  #ftp_uploader.upload '**/*'
  ftp_uploader.upload 'blank.html'
end

