class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :available_inventory, presence: true, numericality: { only_integer: true }
end
