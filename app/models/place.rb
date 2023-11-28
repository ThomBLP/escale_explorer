class Place < ApplicationRecord
  belongs_to :category
  has_many :visits

  validates :name, :long, :lat, presence: true
end
