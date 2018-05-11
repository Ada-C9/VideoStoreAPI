class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: true

  def add_to_check_out_count
    self.movies_checked_out_count +=1
    self.save
  end

end
