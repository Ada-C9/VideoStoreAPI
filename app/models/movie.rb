class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :inventory, :numericality => { :greater_than_or_equal_to => 0}

  def self.create_from_request(hash)
    hash["release_date"] = Date.parse(hash["release_date"])

    self.create!(hash)
  end

  def available
    rentals = Rental.where(movie_id: self.id)
    rented = rentals.select{ |rent| !rent.checkin_date }.count
    avail = (self.inventory - rented)
    return avail
  end

  def self.request_query(params)
    full_list = Movie.all
    if !params.empty?
      max_results_num = params["n"].to_i ||= 10
      page_num = params["p"].to_i ||= 1
      sort = params["sort"] ||= :id


      start_index = max_results_num.to_i * (page_num.to_i - 1)

      if start_index > 0
        end_index = (start_index.to_i + max_results_num.to_i) - 1
      else
        end_index = -1
      end

      full_list = full_list.order(sort)[start_index..end_index]
    end
    return full_list
  end

end
