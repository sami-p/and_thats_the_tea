class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :teas

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true

  enum status: { active: 0, cancelled: 1 }
end
