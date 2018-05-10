class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true

  def set_registration(registration)
    self.created_at = DateTime.parse(registration)
  end

  def self.create_from_request(hash)
    cust_data = {
      name: hash["name"],
      address: hash["address"],
      city: hash["city"],
      state: hash["state"],
      postal_code: hash["postal_code"],
      phone: hash["phone"],
    }

    instance = self.create!(cust_data)

    if hash["registered_at"]
      instance.set_registration(hash["registered_at"])
    end
    return instance
  end

  def checkedout
    rentals = Rental.where(customer_id: self.id)
    rented_count = rentals.select{ |ren| !ren.checkin_date }.count
    return rented_count
  end

  def self.request_query(params)

  end

end
