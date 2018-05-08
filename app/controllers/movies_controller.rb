class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date])
  end


  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :inventory, :overview, :release_date, :title]), status: :ok
    else
      render json: { ok: false, errors: "Movie not found" }, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json:movie.as_json(only: [:title, :overview, :release_date, :inventory, :id]), status: :ok
    else
      render json: { ok: false, errors: movie.errors },
      status: :bad_request
    end
  end
end

private

def movie_params
  return params.permit(:inventory, :overview, :release_date, :title)
end
