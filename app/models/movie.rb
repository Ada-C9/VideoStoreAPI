class Movie < ApplicationRecord
  has_and_belongs_to_many :customers
  has_many :rentals

  validates :title, presence: true

  def set_avail_inventory
    # because available_inventory is nil by default (see seed files), we have to set it equal to inventory
    self.available_inventory = self.inventory
    # TODO: self.available_inventory must not be a larger value than inventory
    # TODO: self.available_inventory attribute can't go below 0
  end

  def dec_avail_inventory
    # this method decrements available_inventory for that movie by 1; we call this in movies_controller check_out method
    self.available_inventory -= 1

  end

  def inc_avail_inventory
    # this method increments available_inventory for that movie by 1; we call this in movies_controller check_in method
    self.available_inventory += 1
  end


end
