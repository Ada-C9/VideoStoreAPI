class Movie < ApplicationRecord
  has_many :rentals
  validates :title, presence: true
  validates :overview,presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def available_inventory
    return self.inventory
  end
end
