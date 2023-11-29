class Category < ApplicationRecord
  has_many :places

  validates :name, presence: true

  EMOJI_CATEGORIES = {
    'spectacles' => '🎬',
    'patrimoine' => '🏛️',
    'restaurants' => '🍔',
    'loisirs' => '⚽',
    'bars' => '🚶',
    'musees' => '🎨'
  }
end
