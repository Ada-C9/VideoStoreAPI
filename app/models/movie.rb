class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available_inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  def available_inventory
    checked_out_count = Rental.where(movie_id: self.id, check_in: nil).count
    return self.inventory - checked_out_count
  end

  # def inventory_available?
  #   if self.available_inventory.nil?
  #     self.available_inventory = self.inventory
  #   end
  #
  #   return self.inventory > 0
  # end
  #
  # def inventory_check_out
  #     self.inventory -= 1
  # end
  #
  #
  # def inventory_check_in
  #   self.inventory += 1
  # end

end
