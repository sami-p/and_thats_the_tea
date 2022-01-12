class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscription

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true
end
