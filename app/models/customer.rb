class Customer < ApplicationRecord
  has_many :rentals

  validates :name, :address, :city, :state, :postal_code, :phone, presence: true

  validates :postal_code, length: { is: 5 }

  # validates :phone, length: { is: 10 }

  def movies_checked_out_count
    movies = self.rentals.select{ |rental| rental.status == 'checked_out' }

    return movies.count
  end
end
