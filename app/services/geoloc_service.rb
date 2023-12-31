# app/services/mapbox_service.rb
class GeolocService
  def initialize
    Mapbox.access_token = ENV.fetch('MAPBOX_ACCESS_TOKEN')
  end

  def get_duration(origin, destination, travel_mode)
    response = Mapbox::Directions.directions(
      [
        { latitude: origin.first, longitude: origin.last },
        { latitude: destination.first, longitude: destination.last }
      ],
      travel_mode
    )

    seconds = response.first.dig("routes", 0, "duration")
    return if seconds.nil?

    seconds / 60
  end

  def localize_city
    result = Geocoder.search.first
    @city = result.city || result.first.address_components.first["long_name"]
  end
end
