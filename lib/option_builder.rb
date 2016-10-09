require 'ostruct'

class OptionBuilder
  def initialize
    @option = {}
  end

  def set_title(title)
    @option[:title] = title
  end

  def set_resources(resources)
    resources.each do |resource|
      unless @option.has_key? resource[:key]
        @option[resource[:key]] = resource[:value]
      else
        raise RuntimeError.new "Duplicated key: #{resource[:key]}"
      end
    end
  end

  def set_partials(partials)
    partials.each do |partial|
      unless @option.has_key? partial[:key]
        @option[partial[:key]] = partial[:value]
      else
        raise RuntimeError.new "Duplicated key: #{partial[:key]}"
      end
    end
  end

  def set_breadcrumbs(page)
    @option[:breadcrumbs] = breadcrumbs page
  end

  def build
    OpenStruct.new @option
  end

  private

  def breadcrumbs(leaf_page)
    breadcrumbs = [{ title: leaf_page.title }]

    page = leaf_page.parent
    while page
      breadcrumbs.unshift({ title: page.title, path: page.path })
      page = page.parent
    end

    breadcrumbs
  end
end
