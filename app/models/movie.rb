class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy

  validates :title, presence: true
  validates :inventory, presence: true, numericality: true
end
