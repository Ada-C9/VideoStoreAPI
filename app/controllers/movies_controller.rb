class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :title, :overview, :release_date])
  end


end
