class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(except: [:created_at, :updated_at], status: :ok)
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(except: [:created_at, :updated_at], status: :ok)
    else
      render json: {
        errors: {
          id: ["No movie with ID #{params[:id]}"]
        }
      }, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: movie.as_json(except: [:created_at, :updated_at], status: :ok)
    else
      render json: {
        errors: movie.errors.messages
      }, status: :bad_request
    end
  end


  private
  def movie_params
    params.require(:movie).permit(:title, :inventory, :release_date, :overview)
  end

end
