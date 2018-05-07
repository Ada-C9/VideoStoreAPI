require 'pry'

class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :title, :overview, :release_date])
  end

  def show
    # binding.pry
    movie = Movie.find_by(id: params[:id])

    render json: movie.as_json(only: [:overview, :release_date, :title], status: :ok)

    puts "MOVIE :#{movie.id}"
  end
end
