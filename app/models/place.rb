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
    GeolocService.new.get_duration([45.76950039018254, 4.834805615523664], [lat, long], journey.travel_mode).round(0)
  end

# d2d67abe1fd83db7c679df1f8447672f482ea37d
  def review_ratings_average
    reviews.pluck(:rating)
    # ...
  end
end
