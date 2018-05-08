class Rental < ApplicationRecord



  def due_date
    # self.check_in + 7 days <<--- not if they return it early
  end

  def returned?
    # boolean?
    # if returned becomes available
    # inventory + 1
    # check_in date gets set
    #
  end

end
