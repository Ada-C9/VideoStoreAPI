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
    a = params[:sort]
    b = params[:p].to_i
    c = params[:n].to_i
    customers = Customer.all
    customers = customers.order(a) if a
    customers = customers.to_a

    if b > 0 || c > 0
      b = 1 if b == 0
      c = 10 if c == 0

      start = ( b - 1 ) * c
      finish = start + c

      customers = customers[start...finish]
    end

    return customers
  end
end
