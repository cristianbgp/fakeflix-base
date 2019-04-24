module Api
  class SeriesController < ApplicationController
    def index
      if params.key? "filter"
        series = Serie.where(status: params[:filter])
      else
        series = Serie.all
      end
      render json: series.as_json(methods: :rented)
    end

    def show
      render json: Serie.find(params[:id]).as_json(methods: [
        :rented,
        :total_duration,
        :episodes_list,
        :episodes_count
      ])
    end

    def rating
      serie = Serie.update(params[:id], rating: params[:rating])
      render json: serie, status: :ok
    end

    def create
      @serie = Serie.new(serie_params)
      if @serie.save
        render json: @serie, status: :ok
      else
        render json: @serie.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @serie = Serie.find(params[:id])
      if @serie.update(serie_params)
        render json: @serie, status: :ok
      else
        render json: @serie.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @serie = Serie.find(params[:id])
      @serie.destroy
      render nothing: true, status: :no_content
    end
  end
end