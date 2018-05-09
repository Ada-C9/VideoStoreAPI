class Rental < ApplicationRecord
  require 'pry'
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, presence: true
  validates :movie_id, presence: true
  # validates :check_in, presence: true
  validates :check_out, presence: true

  def assign_check_out_date
    self.check_out = DateTime.now
  end

  def assign_due_date
    self.due_date = self.check_out + 7
  end

end
