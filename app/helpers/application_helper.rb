module ApplicationHelper
  def display_name(name)
    name = "musées" if name == "musees"
    return name.capitalize
  end
end
