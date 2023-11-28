class Visit < ApplicationRecord
  belongs_to :place, :journey
  has_many :reviews, dependent: :destroy
end
