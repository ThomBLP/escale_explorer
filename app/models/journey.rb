class Journey < ApplicationRecord
  belongs_to :user
  has_many :visits, dependent: :destroy
  has_many :places, through: :visits

  TRAVEL_MODES = ['driving', 'walking', 'cycling']

  TRAVEL_MODES_EMOJI = {
    'driving' => '🚗',
    'walking' => '🚶',
    'cycling' => '🚴'
  }

  def travel_emoji
    TRAVEL_MODES_EMOJI[travel_mode]
  end

  def self.travel_emoji(travel_mode)
    TRAVEL_MODES_EMOJI[travel_mode]
  end

  def total_travel
    self.places.sum { |p| p.travel_time(self) }
  end

  def total_activities
    self.places.sum(:visit_duration)
  end

  def total_duration
    self.total_travel + self.total_activities
  end

end
