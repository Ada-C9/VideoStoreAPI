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
end
