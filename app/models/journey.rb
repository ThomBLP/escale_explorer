class Journey < ApplicationRecord
  belongs_to :user
  has_many :visits, dependent: :destroy
  has_many :places, through: :visits

  TRAVEL_MODES = ['driving', 'walking', 'cycling']

  TRAVEL_MODES_EMOJI = {
    'walking' => '🚶',
    'driving' => '🚗',
    'cycling' => '🚴'
  }

  def travel_emoji
    TRAVEL_MODES_EMOJI[travel_mode]
  end

  def self.travel_emoji(travel_mode)
    TRAVEL_MODES_EMOJI[travel_mode]
  end

  def total_travel
    return 0 unless places.any?

    Mapbox.access_token = ENV.fetch('MAPBOX_ACCESS_TOKEN')

    start = { latitude: 45.76950039018254, longitude: 4.834805615523664 }
    coordinates = places.map do |place|
      { latitude: place.lat, longitude: place.long }
    end

    coordinates.unshift(start)
    coordinates.push(start)

    response = Mapbox::Directions.directions(
      coordinates,
      travel_mode
    )

    seconds = response.first.dig("routes", 0, "duration")
    return if seconds.nil?

    seconds.fdiv(60).round
  end

  def total_activities
    self.places.sum(:visit_duration)
  end

  def total_duration
    self.total_travel + self.total_activities
  end

end
