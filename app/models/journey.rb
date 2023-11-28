class Journey < ApplicationRecord
  belongs_to :user
  has_many :visits, dependent: :destroy

  validates :start_time, presence: true
end
