class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :movie_id, presence: true
  validates :customer_id, presence: true

  # after_save :set_return_to_false
  # after_save :reduce_inventory


  def get_due_date
    return calc_due_date
  end

  private

  def calc_due_date
    return checkout_date + 7
  end
  #
  # def set_return_to_false
  #   rental.update(returned?: false)
  # end

end
