class Customer < ApplicationRecord
  validates :name, :phone, presence: true
  has_many :rentals

  def self.add_movie(customer)
    customer.movies_checked_out_count += 1
    customer.save
  end

  def self.remove_movie(customer)
    customer.movies_checked_out_count -= 1
    customer.save
  end
end
