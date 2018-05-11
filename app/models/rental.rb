class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :movie_id, presence: true
  validates :customer_id, presence: true

  def get_due_date
    return calc_due_date
  end

  def self.get_checked_out
    # return Rental.all.where(returned? == false)
    return self.select { |rental| rental.returned? == false }
  end

  def self.get_overdue
    checked_out_rentals = Rental.get_checked_out
    # overdue_rentals = checked_out_rentals.where(Date.today > get_due_date)
    overdue_rentals = checked_out_rentals.select { |rental| Date.today > rental.get_due_date }
    return overdue_rentals
  end


  private

  def calc_due_date
    return checkout_date + 7
  end

end
