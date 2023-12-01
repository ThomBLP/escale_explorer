class Place < ApplicationRecord
  belongs_to :category
  has_many :visits, dependent: :destroy
  has_many :reviews, through: :visits

  validates :name, :long, :lat, presence: true

  def travel_duration
    GeolocService.new.get_duration([45.76950039018254, 4.834805615523664], [lat, long], 'walking').round(0)
  end
end
