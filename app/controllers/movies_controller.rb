class MoviesController < ApplicationController

  def index
    @movies = Movie.all
      render :index, status: :ok
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
      render :show, status: :ok
    end
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save!
    render :create, status: :ok
    # @movie = Movie.new(movie_params)
    # @movie.save!
    # render json: {id: movie.id}, status: :ok
  end

  private
  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
