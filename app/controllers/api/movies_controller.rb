module Api
  class MoviesController < ApplicationController
    def index
      if params.key? "filter"
        render json: Movie.where(status: params[:filter]), status: :ok
      else
        render json: Movie.all, status: :ok
      end
    end

    def show
      render json: Movie.find(params[:id])
    end

    def playback
      movie = Movie.find(params[:id])
      movie.playback = params[:progress]
      movie.save()
      render json: { message: "Update playback movie" }, status: :ok
    end
  
    def rating
      Movie.update(params[:id], :rating => params[:rating])
      render json: { message: "Update rating movie" }, status: :ok
    end
  
  end
end