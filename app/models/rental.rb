class Rental < ApplicationRecord
  belongs_to :customer#, counter_cache: :movies_checked_out_count
  belongs_to :movie

  validates :movie_id, presence: true
  validates :customer_id, presence: true
  validates :check_out, presence: true
  validates :due_date, presence: true
  validates_datetime :due_date, :after => :check_out
  validates_datetime :check_in, :after => :check_out, allow_nil: true
end
