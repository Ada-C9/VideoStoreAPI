class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date])
  end

  def show
    @movie = Movie.find_by(id: params[:id])

    if @movie.nil?
      render json: {
        errors: {
          id: ["No movie with ID #{params[:id]}"]
        }
      }, status: :not_found
    else
      render json: @movie.as_json(only: [:id, :title, :overview, :release_date, :inventory, :available_inventory])
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      # Success
      render json: { id: movie.id }, status: :ok
    else
      # Failure
      render json: { errors: movie.errors.messages }, status: :bad_request
    end
  end

private

  def movie_params
    return params.permit(:id, :title, :overview, :release_date, :inventory, :available_inventory)
  end

end
