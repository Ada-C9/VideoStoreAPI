class Movie < ApplicationRecord
  validates :title, presence: true 
  validates :inventory, presence: true
  has_many :rentals
end
