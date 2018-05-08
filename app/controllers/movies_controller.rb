class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :inventory, :title, :overview, :release_date, :available_inventory]), status: :ok
  end

  def show
    # binding.pry
    movie = Movie.find_by(id: params[:id])

    if movie.nil?
      render json: {
        errors: {
          id: ["No movie like that found, #{params[:id]}"]
        }
        }, status: :not_found
      else
        render json: movie.as_json(only: [:overview, :release_date, :title, :inventory, :available_inventory]), status: :ok
        # won't work unless rabl
        # render 'movies/show'
      end
    end

    def create
      movie = Movie.new(movie_params)

      if movie.save
        render json: { id: movie.id}, status: :ok
      else
        render json: { errors: movie.errors.messages }, status: :bad_request
      end
    end

    private
    def movie_params
      params.permit(:title, :overview, :release_date, :inventory)
    end
  end
