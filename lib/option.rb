#
# Utility for converting Hash to OpenStruct
# Copyright (C) 2016 Me All Rights Reserved.
#

require 'json'

module Option
  def self.create(hash)
    JSON.parse hash.to_json, object_class: OpenStruct   
  end

  def self.default
    Option.create {}
  end
end
