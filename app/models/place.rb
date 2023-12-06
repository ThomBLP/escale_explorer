class Place < ApplicationRecord
  belongs_to :category
  has_many :visits, dependent: :destroy
  has_many :reviews, through: :visits

  validates :name, :long, :lat, presence: true

  geocoded_by :address, latitude: :lat, longitude: :long
  after_validation :geocode

  def location
    [lat, long].compact.join(', ')
  end

  def travel_time(journey)
    if journey.places.any?
      last_place = journey.places.last
      coordinates_origin = [last_place.lat, last_place.long]
    else
      coordinates_origin = [45.76950039018254, 4.834805615523664]
    end
    
    GeolocService.new.get_duration(coordinates_origin, [lat, long], journey.travel_mode).round(0)
  end

  def review_ratings_average
    reviews.pluck(:rating)
    # ...
  end

  include PgSearch::Model
    pg_search_scope :search_by_name_and_shortdescription,
    against: [ :name, :shortdescription ],
    using: {
      tsearch: { prefix: true }
  }
end
