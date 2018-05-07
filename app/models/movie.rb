class Movie < ApplicationRecord

  validates :title, :inventory, presence: true
  validates :inventory, numericality: true

end
