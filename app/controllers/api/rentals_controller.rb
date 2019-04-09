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
      movie_found.rentals.create(
        paid_price: movie_found.price
      )
      render json: { message: "Rent a movie" }, status: :created
    end
    
    def serie
      serie_found = Serie.find(params[:id])
      serie_found.rentals.create(
        paid_price: serie_found.price
      )
      render json: { message: "Rent a serie" }, status: :created
    end
  end
end