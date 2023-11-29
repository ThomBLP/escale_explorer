class Category < ApplicationRecord
  has_many :places

  validates :name, presence: true

  EMOJI_CATEGORIES = {
    'Monuments' => '🏛️',
    'Restauration' => '🍔',
    'Cinéma' => '🎬',
    'Sport et loisirs' => '⚽',
    'Balade' => '🚶',
    'Art' => '🎨'
  }
end
