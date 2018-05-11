class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true
  validates :phone, presence: true
  validates :phone, length: { is: 14 }
end
