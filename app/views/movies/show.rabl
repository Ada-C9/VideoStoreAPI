object @movie

attributes :title, :overview, :release_date, :inventory

node(:available_inventory) { |movie|
  checked_out_count = 0
  movie.rentals.each do |rental|
    puts rental
    rental_range = rental.start_date..rental.end_date
    if rental_range.include?(Date.today)
      checked_out_count += 1
    end
  end
  movie.inventory - checked_out_count
}
