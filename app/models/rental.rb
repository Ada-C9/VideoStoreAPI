class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true

  after_initialize :default_checkout_status

  def check_date
    self.checkout_date= Date.today
    self.due_date= (self.checkout_date + 7)
  end

  def build_rental
    new_inventory = self.movie.available_inventory -= 1
    customer_movie_count = self.customer.movies_checked_out_count += 1

    self.update_attribute(:checked_out, true)
    self.movie.update_attribute(:available_inventory, new_inventory)
    self.customer.update_attribute(:movies_checked_out_count, customer_movie_count)
  end

  def build_return
    new_inventory = self.movie.available_inventory += 1
    customer_movie_count = self.customer.movies_checked_out_count -= 1

    self.update_attribute(:checked_out, false)
    self.movie.update_attribute(:available_inventory, new_inventory)
    self.customer.update_attribute(:movies_checked_out_count, customer_movie_count)
  end

  private
  def default_checkout_status
    self.checked_out ||= self.checked_out = false
  end
end
