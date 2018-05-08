class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date, :inventory, :overview, :available_inventory])
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:title, :release_date, :inventory, :overview, :available_inventory]), status: :ok
    else
      render json: {ok: false, errors: "Movie not found"}, status: :not_found
    end
  end

  def create
    movie = Movie.create(movie_params)

    if movie.valid?
      render json: { id: movie.id }, status: :ok
    else
      render json: { ok: false, errors: movie.errors }, status: :bad_request
    end
  end

  private
  def movie_params
    return params.permit(:id, :title, :release_date, :inventory, :overview, :available_inventory)
  end
end
