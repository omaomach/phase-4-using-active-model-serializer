class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def summary
    movie = Movie.find(params[:id])
    render json: movie, serializer: MovieSummarySerializer
  end

  # If we wanted to use our new custom serializer to render the full collection of movies, we would need to create another route and action
  # The use of each_serializer: MovieSummarySerializer in our action tells the app to use our custom movie summary serializer to render each of the movies in the collection.
  def summaries
    movies = Movie.all
    render json: movies, each_serializer: MovieSummarySerializer
  end

  private

  def render_not_found_response
    render json: { error: "Movie not found" }, status: :not_found
  end
end
