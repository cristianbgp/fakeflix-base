module Api
  class SeriesController < ApplicationController
    def index
      if params.key? "filter"
        render json: Serie.where(status: params[:filter]), status: :ok
      else
        render json: Serie.all, status: :ok
      end
    end

    def show
      render json: Serie.find(params[:id]).as_json(include: :episodes), status: :ok
    end

    def rating
      serie = Serie.update(params[:id], rating: params[:rating])
      render json: serie, status: :ok
    end
  end
end