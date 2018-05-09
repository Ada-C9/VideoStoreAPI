class Movie < ApplicationRecord
   validates :title, presence: true
   has_many :rentals
   has_many :customers, through: :rentals

   # possible logic to decrement available_inventory

   # returns true if movie is available for checkout
   # returns false if movie isn't available for checkout
   def self.available_inventory?
     self.available_inventory >= 1
   end

  def self.reduce_available_inventory
    self.available_inventory - 1
  end


  def self.available_inventory?
    unless self.available_inventory == 0
      rental_history = self.rentals

      rental_history.each do |item|
        if item.checkout_date.nil && item.rental.checkin_date == nil
          available_inventory -= 1
        end
      end

    end

    return "We do not have that title available now."

   end

end
