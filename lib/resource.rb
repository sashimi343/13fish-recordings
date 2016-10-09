class Resource
  def initialize(key, resource_name)
    @key = key
    @value = load_file resource_name
  end

  def to_hash
    { key: @key, value: @value }
  end

  private

  def load_file(resource_name)
    path = "./src/resources/#{resource_name}.yml"
    if File.exist? path
      YAML.load_file path
    else
      raise RuntimeError.new "Unknown resource file: #{resource_name} (id = #{@id})"
    end
  end
end
