class Movie < ApplicationRecord
  has_many :rentals

  validates :title, :overview, :release_date, :inventory, presence: true

  validates :inventory, numericality: { greater_than: -1 }

  def available_inventory
    checkout_count = 0
    self.rentals.each do |rental|
      if rental.status == 'checked_out'
        checkout_count += 1
      end
    end

    return self.inventory - checkout_count
  end
end
