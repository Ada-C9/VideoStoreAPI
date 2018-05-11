class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available_inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_checkout

    self.available_inventory -= 1
    self.save
  end

  def update_checkin
    self.available_inventory += 1
    self.save
  end

end
