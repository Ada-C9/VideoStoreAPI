class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true 
  validates_numericality_of :inventory, presence: true, greater_than_or_equal_to: 0
end
