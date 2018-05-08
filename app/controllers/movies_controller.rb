require 'pry'

class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :inventory, :title, :overview, :release_date])
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
        render json: movie.as_json(only: [:overview, :release_date, :title, :inventory], status: :ok)
        # won't work unless rabl
        # render 'movies/show'
      end
    end

    def create
      movie = Movie.new(movie_params)

      if movie.save
        render json: { id: movie.id}, status: :created
      else
        render json: { errors: movie.errors.messages }, status: :bad_request
      end
    end

    private
    def movie_params
      params.require(:movie).permit(:title, :overview, :release_date, :inventory)
    end
  end
