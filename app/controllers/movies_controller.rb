class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :overview, :inventory, :release_date]), status: :ok
  end
end
