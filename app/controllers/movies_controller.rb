class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :release_date, :inventory, :overview])
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:title, :release_date, :inventory, :overview]), status: :ok
    else
      render json: {ok: false, errors: "Movie not found"}, status: :not_found
    end
  end
  
end
