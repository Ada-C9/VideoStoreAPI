class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence:true
  validates :phone, presence: true
end
