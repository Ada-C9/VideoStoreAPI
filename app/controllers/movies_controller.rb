class MoviesController < ApplicationController

  def zomg
    render :json => { message: "It works!" }
  end

end
