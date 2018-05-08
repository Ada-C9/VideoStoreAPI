class Rental < ApplicationRecord

  def check_in
  end

  def check_out
  end

  def due_date
    # self.check_in + 7 days
  end

  def movie_available?
  end

end
