class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :overview, :inventory, :available_inventory, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id:params[:id])
    if movie.nil?
      render json:{
        errors:{
          id: ["No movie with ID #{params[:id]}"]
        }
      }, status: :not_found
    else
        render json: movie.as_json(only: [:id, :title, :overview, :inventory, :available_inventory, :release_date], status: :ok)
    end
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory
    if movie.save
      render json: { id: movie.id }, status: :ok
    else
      render json: {
        errors: movie.errors.messages
      }, status: :bad_request
    end
  end

  private
  def movie_params
    return params.permit(:title, :overview, :inventory, :release_date)
  end
end
