class Journey < ApplicationRecord
  belongs_to :user
  has_many :visits, dependent: :destroy
  has_many :places, through: :visits

  TRAVEL_MODES = {
    'driving' => '🚗',
    'walking' => '🚶',
    'cycling' => '🚴'
  }

  def travel_emoji
    TRAVEL_MODES[travel_mode]
  end
end
