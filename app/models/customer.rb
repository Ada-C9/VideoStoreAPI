class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validate :same_name_and_same_phone

  has_many :rentals

  def same_name_and_same_phone
    customers = Customer.where(name: name)

    if customers.any? {|customer| customer.phone == phone}
      errors[:phone] << "Can not have the same name and same phone number"
    end
  end
end
