class Customer < ApplicationRecord
  validates :name, presence: true
  has_many :rentals
  has_many :movies, through: :rentals
end
