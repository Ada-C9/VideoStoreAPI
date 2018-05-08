class MoviesController < ApplicationController

  def index
  movies = Movie.where(title: params[:title])

  render json: movies.as_json(except: [:created_at, :updated_at], status: :ok)

  end
end
