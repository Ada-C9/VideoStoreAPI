class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: customers.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
  end

end
