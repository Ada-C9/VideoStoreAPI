class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
  end

end
