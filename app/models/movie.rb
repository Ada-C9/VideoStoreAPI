class Movie < ApplicationRecord
  has_many :rentals

  validates :title, :overview, :release_date, :inventory, presence: true

  validates :inventory, numericality: { greater_than: -1 }

  def available_inventory
    return inventory
  end
end
