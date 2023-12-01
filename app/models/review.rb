class Review < ApplicationRecord
  belongs_to :visit
  has_one :journey, through: :visit
  has_one :place, through: :visit
  has_one :user, through: :journey

  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, presence: true
end
