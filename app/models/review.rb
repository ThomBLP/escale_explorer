class Review < ApplicationRecord
  AUTHORIZED_RATINGS = (1..5)

  belongs_to :visit
  has_one :journey, through: :visit
  has_one :place, through: :visit

  validates :rating, inclusion: { in: AUTHORIZED_RATINGS }
end
