class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true

  after_initialize :default_checkout_status

  def self.rental_date(rental)
    rental.checkout_date= Date.today
    rental.due_date= (rental.checkout_date + 7)
  end

  def self.build_rental(rental)
    new_inventory = rental.movie.available_inventory -= 1
    customer_movie_count = rental.customer.movies_checked_out_count += 1

    rental.update_attribute(:checked_out, true)
    rental.movie.update_attribute(:available_inventory, new_inventory)
    rental.customer.update_attribute(:movies_checked_out_count, customer_movie_count)
  end

  def self.build_return(rental)
    new_inventory = rental.movie.available_inventory += 1
    customer_movie_count = rental.customer.movies_checked_out_count -= 1

    rental.update_attribute(:checked_out, false)
    rental.movie.update_attribute(:available_inventory, new_inventory)
    rental.customer.update_attribute(:movies_checked_out_count, customer_movie_count)
  end

  private
  def default_checkout_status
    self.checked_out ||= self.checked_out = false
  end
end
