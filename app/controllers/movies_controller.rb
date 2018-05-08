class MoviesController < ApplicationController

  def zomg
    render :json => { message: "It works!" }
  end

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

end
