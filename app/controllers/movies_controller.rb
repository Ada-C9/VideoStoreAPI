class MoviesController < ApplicationController

  def index
    if params[:sort] == "title"
      movies = Movie.all.order(:title).paginate(page: params[:p], per_page: params[:n])
    elsif params[:sort] == "release_date"
      movies = Movie.all.order(:release_date).paginate(page: params[:p], per_page: params[:n])
    else
      movies = Movie.all
    end
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
      render json: movie.as_json(only: [:id]), status: :ok
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
