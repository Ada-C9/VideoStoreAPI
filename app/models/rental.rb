class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :checkout_date, presence: true
  validate :checkout_date_is_valid_date
  def checkout_date_is_valid_date
    errors.add(:checkout_date, 'must be a valid datetime') if ((Date.parse(checkout_date) rescue ArgumentError) == ArgumentError)
  end
end
