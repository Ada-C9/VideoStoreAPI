class MoviesController < ApplicationController
  # protect_from_forgery with: :null_session

  def index
    movies = Movie.all
    render :json => movies.as_json(only: [:id, :title, :release_date, :overview, :inventory, :availa]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      show_movie_hash = {
        title: movie.title,
        overview: movie.overview,
        release_date: movie.release_date,
        inventory: movie.inventory,
        available_inventory: movie.available_inventory,
      }
      render json: show_movie_hash.as_json, status: :ok
    else
      render json: { ok: false, errors: {id: ["Movie not found"]} }, status: :not_found
    end
  end

  def create
    movie = Movie.create(movie_params)

    if movie.valid?
      render json: {id: movie.id}, status: :ok
    else
      render json: {ok: false, errors: movie.errors}, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end

end
