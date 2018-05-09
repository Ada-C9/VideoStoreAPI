require 'pry'
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies.as_json(only: [:id, :title, :release_date])
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only:[:title,:overview,:release_date,:inventory,:available_inventory])
    else
      render json: {ok: false}, status: :not_found
    end
  end

  def create
    movie = Movie.new(title: params[:title], overview: params[:overview], release_date: params[:release_date], inventory: params[:inventory])
    if movie.save
      render json:{id: movie.id}, status: :ok
    else
       render json:{ok: false, error: movie.errors}, status: :bad_request
      end
  end

# remove this #
private
  def posting_film_requirements
    return params.require(:movie).permit(:title,:overview,:release_date,:inventory)
  end
end
