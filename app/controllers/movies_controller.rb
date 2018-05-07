class MoviesController < ApplicationController

  def index
    movie = "it works!"
    render json: movie.as_json
  end

end
