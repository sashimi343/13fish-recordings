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
require 'net/ftp'

class FTPUploader
  def initialize(server, user, password, local_dir, remote_dir = nil)
    @connection = Net::FTP.open server, user, password
    change_local_directory local_dir
    change_remote_directory if remote_dir
  end

  def upload(local_path)
    local_paths = Dir.glob(local_path).reject { |each| ['.', '..'].include? each }
    local_paths.each do |path|
      print "Info: put local file #{path} to remote ..."
      mkdir_p File.dirname(path)
      @connection.put(path, path) if FileTest.file? path
      puts "done"
    end
  end

  private

  def change_local_directory(local_dir)
    if FileTest.directory? local_dir
      Dir.chdir local_dir
    else
      raise ArgumentError.new "Error: local directory '#{local_dir}' does not exist"
    end
  end

  def change_remote_directory(remote_dir)
    remote_dir.split('/').each do |dir_name|
      directories = @connection.list.map { |line| line.split.last }
      if directories.include? dir_name
        @connection.chdir dir_name
      else
        raise ArgumentError.new "Error: remote directory '#{remote_dir}' does not exist"
      end
    end

    puts "Info: remote current directory is #{@connection.pwd}"
  end

  def mkdir_p(path)
    current_directory = @connection.pwd

    directories = path.split('/').reject { |each| each === '.' }

    directories.each do |dir_name|
      directories = @connection.list.map { |line| line.split.last }
      @connection.mkdir(dir_name) unless directories.include? dir_name
      @connection.chdir dir_name
    end

    @connection.chdir current_directory
  end
end
