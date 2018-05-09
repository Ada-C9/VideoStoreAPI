class Movie < ApplicationRecord
  before_validation :set_available_inventory_default, on: :create

  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true }
  validates :available_inventory, presence: true, numericality: { only_integer: true }

  def decrement_available_inventory
    if self.available_inventory > 0
      self.available_inventory -= 1
    end
  end

  private
  def set_available_inventory_default
    puts "Running set available inventory default"
    self.available_inventory = self.inventory
  end
end
