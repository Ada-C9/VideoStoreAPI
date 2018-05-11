class Movie < ApplicationRecord
  has_and_belongs_to_many :customers
  has_many :rentals

  validates :title, presence: true
  validate :available_inventory_cannot_be_greater_than_inventory

  validates :available_inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :inventory, numericality: { only_integer: true, greater_than: 0 }

  after_initialize do |movie|
    self.inventory ||= 0
    self.available_inventory ||= self.inventory
  end

  def dec_avail_inventory
    # this method decrements available_inventory for that movie by 1; we call this in movies_controller check_out method
    self.available_inventory -= 1

  end

  def inc_avail_inventory
    # this method increments available_inventory for that movie by 1; we call this in movies_controller check_in method
    self.available_inventory += 1
  end

  private

  # See: http://guides.rubyonrails.org/active_record_validations.html#custom-methods
  def available_inventory_cannot_be_greater_than_inventory
    if available_inventory > inventory
      errors.add(:available_inventory, "Can't be greater than inventory value")
    end
  end

end
