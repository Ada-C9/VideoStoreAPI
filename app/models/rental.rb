class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def self.check_dependencies(customer, movie)
    if customer.nil?
      return {
        customer_id: ["No such customer"]
      }
    elsif movie.nil?
      return {
        movie_id: ["No such movie"]
      }
    elsif movie.available_inventory < 1
      return {
        inventory: ["No copies of that movie are available"]
      }
    end
    return nil
  end

  def self.create_checkout(customer, movie)
    checkout_date = DateTime.now
    due_date = checkout_date + 7
    checkin_date = nil

    rental = Rental.new(customer_id: customer.id, movie_id: movie.id, checkout_date: checkout_date, due_date: due_date, checkin_date: checkin_date)

    return rental
  end

  def self.process_checkout(customer, movie)
    if customer.movies_checked_out_count == nil
      customer.movies_checked_out_count = 0
      customer.save
    end

    customer.update! movies_checked_out_count: customer.movies_checked_out_count+1

    movie.update! available_inventory: movie.available_inventory-1
  end

  def self.process_checkin(customer, movie)
    Customer.find(customer.id).update_attributes movies_checked_out_count: customer.movies_checked_out_count-1

    Movie.find(movie.id).update_attributes available_inventory: movie.available_inventory+1
  end

end
