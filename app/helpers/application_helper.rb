module ApplicationHelper
  def display_name(name)
    name = "musées" if name == "musees"
    return name.capitalize
  end

  def svg_tag(path, options = {})
    svg_content = File.open("app/assets/images/#{path.downcase}.svg", "rb") do |file|
      raw file.read
    end

    if options[:class].present?
      svg_content.sub!(/<svg(.*?)>/, "<svg\\1 class='#{options[:class]}'>")
    end

    raw svg_content
  end
end
