class Rental < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :valid_date_range

  belongs_to :customer
  belongs_to :movie

  def valid_date_range
    if start_date < end_date
      return true
    end
    errors.add(:start_date, "Can't be after end date.")
  end


  def
  end
  
end
