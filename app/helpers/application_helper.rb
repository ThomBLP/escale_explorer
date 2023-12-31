module ApplicationHelper
  def display_name(name)
    name = "musées" if name == "musees"
    return name.capitalize
  end

  def svg_tag(path, options = {})
    svg_content = File.open("app/assets/images/#{path.downcase}.svg", "rb") do |file|
      raw file.read
    end

    svg_content.sub!(/<svg(.*?)>/, "<svg\\1 class='#{options[:class]}'>") if options[:class].present?

    raw svg_content
  end

  def category_link(category, category_ids)
    category_ids = Array(category_ids)
    if category_ids.present? && category_ids.include?(category.id.to_s)

      new_params = category_ids.reject { |c| c == category.id.to_s }
    else
      new_params = (category_ids + [category.id]).flatten
    end

    link_to(request.params.merge(category_ids: new_params.presence), class: "category_home #{'active' if category_ids.present? && category_ids.include?(category.id.to_s)}") do
      category.emoji
    end
  end

  def display_time(time)
    hours = "#{time / 60}h"
    minutes = "#{time % 60}mn"
    if hours == "0h"
      minutes
    elsif minutes == "0mn"
      hours
    else
    "#{hours} et #{minutes}"
    end
  end

  def journey_params
    request.parameters.except('controller', 'action')
  end
end
