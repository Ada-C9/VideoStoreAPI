class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def available_inventory
    return self.inventory - self.rentals.where(check_in_status: false).count
  end
end
