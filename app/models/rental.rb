class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validates :due_date, presence: true, if: :checkout_date?

  def checkout_date?
    !checkout_date.nil?
  end

end
