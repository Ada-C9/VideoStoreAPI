class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, numericality: true
  validates :inventory, numericality: {greater_than_or_equal_to: 0}

end
