class Rental < ApplicationRecord
  before_create do
    self.checkout_date = Date.today
    self.due_date = Date.today + 7
  end

  belongs_to :movie
  belongs_to :customer

  # def find_rental_movie(rental_params)
  #   return Movie.find_by(id: rental_params[:movie_id])
  # end


end
