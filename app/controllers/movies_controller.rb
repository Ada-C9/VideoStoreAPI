class MoviesController < ApplicationController

  def index
    @movies = Movie.all
      render :index, status: :ok
  end

  def show
    @movie = Movie.find_by(id: movie_params[:id])
    if @movie.nil?
      render json: {
        errors: {
          id: ["No movie with ID #{movie_params[:id]}"]
        }
      }, status: :not_found
    else
      render :show, status: :ok
    end
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save!
    render :create, status: :ok
  end

  private
  def movie_params
    params.permit(:id, :title, :overview, :release_date, :inventory)
  end
end
