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
    
    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        render json: @movie, status: :ok
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        render json: @movie, status: :ok
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      render nothing: true, status: :no_content
    end
  end
end