module Api
  class MoviesController < ApplicationController
    def index
      if params.key? "filter"
        movies = Movie.where(status: params[:filter])
      else
        movies = Movie.all
      end
      render json: movies.as_json(methods: :rented)
    end

    def show
      render json: Movie.find(params[:id]).as_json(methods: :rented)
    end

    def playback
      movie = Movie.update(params[:id], playback: params[:progress])
      render json: movie, status: :ok
    end
  
    def rating
      movie = Movie.update(params[:id], rating: params[:rating])
      render json: movie, status: :ok
    end
  
  end
end