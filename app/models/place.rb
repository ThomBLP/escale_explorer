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

  def travel_duration
    GeolocService.new.get_duration([45.76950039018254, 4.834805615523664], [lat, long], 'walking').round(0)
  end


  # def self_find_by_name(name)
  #   find_by(name: name)
  # end
end
