class Rental < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :valid_date_range
  validate :enough_inventory_for_rent

  belongs_to :customer
  belongs_to :movie

  def valid_date_range
    if start_date < end_date
      return true
    end
    errors.add(:start_date, "Can't be after end date.")
  end


  def enough_inventory_for_rent
    range = start_date..end_date
    count = 0
    self.movie.rentals.each do |rent|
      if range.include?(rent.start_date) || range.include?(rent.end_date)
        count += 1
      end
    end

    if count >= self.movie.inventory
      errors.add( :range,"All copies of the movie are rented for this date range")
    end
  end

end
