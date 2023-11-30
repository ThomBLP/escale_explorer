class Category < ApplicationRecord
  has_many :places

  validates :name, presence: true

  EMOJI_CATEGORIES = {
    'musees' => '🏛️',
    'restaurants' => '🍔',
    'spectacles' => '🎬',
    'loisirs' => '⚽',
    'bars' => '🚶',
    'patrimoine' => '🎨'
  }
end
