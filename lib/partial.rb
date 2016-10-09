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
    paths = Dir.glob "./src/partials/#{partial_name}"
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
