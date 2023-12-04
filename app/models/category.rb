class Category < ApplicationRecord
  has_many :places

  validates :name, presence: true

  DISPLAY_CATEGORIES = {
    'spectacles' => {
      emoji: '🎭',
      display_name: 'Spectacles'
    },
    'patrimoine' => {
      emoji: '🏛️',
      display_name: 'Patrimoine'
    },
    'restaurants' => {
      emoji: '👨‍🍳',
      display_name: 'Restaurants'
    },
    'loisirs' => {
      emoji: '☘️',
      display_name: 'Loisirs'
    },
    'bars' => {
      emoji: '🍷',
      display_name: 'Bars'
    },
    'musees' => {
      emoji: '🎨',
      display_name: 'Musées'
    }
  }

  def emoji
    DISPLAY_CATEGORIES.dig(name, :emoji)
  end

  def display_name
    DISPLAY_CATEGORIES.dig(name, :display_name)
  end
end
