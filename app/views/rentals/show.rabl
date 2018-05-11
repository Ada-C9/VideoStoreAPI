object @rental
attributes :id, :customer_id, :movie_id
node(:ok, if: :nil?) { |rental| false }
