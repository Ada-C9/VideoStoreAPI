class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: :true, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
    message: "Only allows letters" }

  def update_count(params)
    if params == "in"
      self.movies_checked_out_count -= 1
    elsif params == "out"
      self.movies_checked_out_count += 1
    end

    self.save
  end
end
