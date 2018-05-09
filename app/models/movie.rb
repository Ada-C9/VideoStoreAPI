class Movie < ApplicationRecord
   validates :title, presence: true
   has_many :rentals
   has_many :customers, through: :rentals

   # possible logic to decrement available_inventory
   def self.available_inventory?
     unless self.available_inventory == 0
       rented_copies = self.rental.where(id: self.id)

         rented_copies.each do |copy|
           if copy.checkout_date && copy.rental.checkin_date == nil

             available_inventory -= 1

           end

         end
       else

         return "We do not have that title available now."

     end


   end

end
