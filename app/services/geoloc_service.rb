# app/services/mapbox_service.rb
class GeolocService
  def initialize
    Mapbox.access_token = ENV['MAPBOX_ACCESS_TOKEN']
  end

  def get_duration_by_car(origin, destination)
    response = Mapbox::Directions.directions(
      [
        { latitude: origin.first, longitude: origin.last },
        { latitude: destination.first, longitude: destination.last }
      ],
      "driving-traffic"
    )
    seconds = response.first.dig("routes", 0, "duration")
    return if seconds.nil?
    seconds / 60
  end

  def get_duration_by_cycle(origin, destination)
    response = Mapbox::Directions.directions(
      [
        { latitude: origin.first, longitude: origin.last },
        { latitude: destination.first, longitude: destination.last }
      ],
      "cycling"
    )
    seconds = response.first.dig("routes", 0, "duration")
    return if seconds.nil?
    seconds / 60
  end

  def get_duration_by_walk(origin, destination)
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

  def localize_me
    @ip = request.remote_ip
    @coordinates = Geocoder.coordinates(@ip)
  end

  def localize_city
    result = Geocoder.search(@ip).first
    @city = result.city || result.first.address_components.first["long_name"]
  end
end
