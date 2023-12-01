class Place < ApplicationRecord
  belongs_to :category
  has_many :visits, dependent: :destroy
  has_many :reviews, through: :visits

  validates :name, :long, :lat, presence: true
end
