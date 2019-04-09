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
  end
end