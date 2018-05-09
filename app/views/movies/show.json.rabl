object @movie

attributes :id, :title, :release_date, :overview, :inventory

node(:available_inventory) { |movie| movie.available}
