class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true

  def movies_checked_out_count
    checked_out_count = Rental.where(customer_id: self.id, check_in: nil).count
  end

end
