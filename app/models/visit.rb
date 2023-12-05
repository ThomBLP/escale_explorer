class Visit < ApplicationRecord
  belongs_to :place
  belongs_to :journey
  has_one    :review, dependent: :destroy
end
