class Movie < ApplicationRecord
  before_validation :set_available_inventory_default

  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true }
  validates :available_inventory, presence: true, numericality: { only_integer: true }


  private
  def set_available_inventory_default
    self.available_inventory = self.inventory
  end
end
