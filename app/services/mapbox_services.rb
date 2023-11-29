# app/services/mapbox_service.rb
class MapboxServices
  def initialize
    Mapbox.access_token = ENV['MAPBOX_ACCESS_TOKEN']
  end

  def get_duration(origin, destination)
    response = Mapbox::Directions.directions(
      [
        { latitude: origin.first, longitude: origin.last },
        { latitude: destination.first, longitude: destination.last }
      ],
      "walking"
    )

    seconds = response.first.dig("routes", 0, "duration")
    return if seconds.nil?

    seconds / 60
  end
end
