class Visit < ApplicationRecord
  belongs_to :place
  belongs_to :journey
  has_many :reviews, dependent: :destroy
end
