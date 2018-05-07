class Customer < ApplicationRecord

  validates :name, presence: true

  def set_registration(registration)
    self.created_at = DateTime.parse(registration)
  end

  def self.create_from_json(hash)
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


end
