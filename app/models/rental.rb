class Rental < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :valid_date_range

  def valid_date_range
    if start_date < end_date
      return true
    end
    errors.add(:start_date, "Can't be after end date.")
  end

end
