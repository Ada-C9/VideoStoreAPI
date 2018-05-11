class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def returned?
    # boolean?
    # if returned becomes available
    # inventory + 1
    # check_in date gets set
    
  end

end
