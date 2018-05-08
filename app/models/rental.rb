class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movies

  validates :due_date, presence: true
end
