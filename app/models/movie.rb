class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def a_checkout
    if self.available_inventory > 0
      self.available_inventory-=1
      self.save
    else
      return false
    end
  end

  def a_check_in
    self.inventory+=1
  end
end
