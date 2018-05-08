class MoviesController < ApplicationController

  def index
    @movies = Movie.where(title: params[:title])
    render 'movies/index'
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    if @movie
      render 'movies/show'
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
        render json: {id: movie.id}, status: :ok
      else
        render json: {errors: movie.errors.messages}, status: :bad_request
      end

    end

    private
    def movie_params
      return params.require(:movie).permit(:title, :overwiew, :inventory, :release_date)
    end

  end
