class MoviesController < ApplicationController

  def index
    movies = Movie.all
    # render :json => movies
    render(json: movies.as_json(only: [:id, :title, :release_date]), status: :ok)
  end

  def show
  end

  def create
  end
end
