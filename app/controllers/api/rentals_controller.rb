module Api
  class RentalsController < ApplicationController
    def index
      render json: Rental.all, status: :ok
    end
  
    def show
      render json: Movie.find(params[:id]), status: :ok
    end
  
    def movie
      movie_found = Movie.find(params[:id])
      rental = movie_found.rentals.create(
        paid_price: movie_found.price
      )
      render json: rental, status: :created
    end
    
    def serie
      serie_found = Serie.find(params[:id])
      rental = serie_found.rentals.create(
        paid_price: serie_found.price
      )
      render json: rental, status: :created
    end

    def create
      @rental = Rental.new(rental_params)
      if @rental.save
        render json: @rental, status: :ok
      else
        render json: @rental.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @rental = Rental.find(params[:id])
      if @rental.update(rental_params)
        render json: @rental, status: :ok
      else
        render json: @rental.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @rental = Rental.find(params[:id])
      @rental.destroy
      render nothing: true, status: :no_content
    end
  end
end