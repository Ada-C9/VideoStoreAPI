class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available_inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true


  def inventory_available?
    if self.available_inventory.nil?
      self.available_inventory = self.inventory
    end

    return self.available_inventory > 0
  end

  def inventory_check_out
    self.available_inventory -= 1
  end


  def inventory_check_in
    self.available_inventory += 1
  end

end
