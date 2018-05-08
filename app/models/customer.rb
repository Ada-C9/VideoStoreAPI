class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  # validates :movies_checked_out_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  def movies_checked_out_count
    checked_out_count = Rental.where(customer_id: self.id, check_in: nil).count
  end


  # def movie_check_out
  #   if self.movies_checked_out_count.nil?
  #     self.movies_checked_out_count = 0
  #   end
  #
  #   self.movies_checked_out_count += 1
  # end
  #
  # def movie_check_in
  #   self.movies_checked_out_count -= 1
  # end
end
