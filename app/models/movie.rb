class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def a_checkout
      self.inventory-=1
  end

  def a_check_in
    self.inventory+=1
  end

end
