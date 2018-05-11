class Customer < ApplicationRecord
  validates :name, :phone, :address, :city, :state, :postal_code, presence: true

  has_many :rentals

  # scope :by_name, -> (name) { where(name: name) }

  def movies_checked_out_count
    return Rental.where(customer_id: self.id).where(returned: false).count
  end

  def assign_registered_date
    self.update_attributes(registered_at: self.created_at)
  end
end
