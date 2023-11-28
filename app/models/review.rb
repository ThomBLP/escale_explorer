class Review < ApplicationRecord
  belongs_to :visit

  validates :rating, presence: true
end
