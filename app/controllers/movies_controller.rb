class MoviesController < ApplicationController
  def index

    params[:sort] ? (sort = params[:sort].to_sym) : sort = :id

    @movies = Movie.order(sort).paginate(page: params[:p], per_page: params[:n])

  end

  def show

    @movie = Movie.find_by(id: params[:id])

    render json: {ok: false, error: :not_found}, status: :not_found if @movie.nil?
  end

  def create
    movie = Movie.create(movies_params)

    if movie.valid?
      render json: {id: movie.id}, status: :ok
    else
      render json: {ok: false, errors: movie.errors}, status: :bad_request
    end
  end

  private
  def movies_params
    params.permit(:title, :release_date, :overview, :inventory, :p, :n, :sort)
  end
end
