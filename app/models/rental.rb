class Rental < ApplicationRecord
  before_create do
    self.checkout_date = Date.today
    self.due_date = Date.today + 7
  end

  belongs_to :movie
  belongs_to :customer

end
