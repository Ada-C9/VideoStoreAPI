class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true
  has_many :rentals

  def get_available_inventory
    checked_out_count = 0
    self.rentals.each do |rental|
      if rental.return_date.nil?
        checked_out_count += 1
      end
    end
    return self.inventory - checked_out_count
  end
end
