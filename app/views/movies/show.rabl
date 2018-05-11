object @movie
attributes :title, :overview, :release_date, :inventory
node(:available_inventory) { |movie| movie.available_inventory }
