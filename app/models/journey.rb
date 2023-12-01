class Journey < ApplicationRecord
  belongs_to :user
  has_many :visits, dependent: :destroy
  has_many :places, through: :visits

  # validates :start_time, presence: true
end
