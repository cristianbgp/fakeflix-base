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
  end
end