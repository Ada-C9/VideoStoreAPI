class Movie < ApplicationRecord

  validates :title, :inventory, presence: true

  validates :inventory, numericality: true

  has_many :rentals

end
