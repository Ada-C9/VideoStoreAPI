JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create_from_request(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create_from_request(movie)
end
