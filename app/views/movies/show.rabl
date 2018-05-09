object @movie

attributes :title, :overview, :release_date, :inventory, :id

node(:available_inventory) { |movie|
  movie.get_available_inventory
}
