require 'rails_helper'

describe Api::RentalsController do
  before do
    @movie = Movie.create(
      title: "Scott pilgrim vs the world",
      description: "Scott pilgrim se la pasa peleando con los ex de Ramona",
      rating: 0,
      price: 30,
      status: "billboard",
      playback: 20
    )
    @serie = Serie.create(
      title: "Black Mirror",
      description: "Una serie de capitulos bien raros",
      rating: 0,
      price: 30,
      status: "billboard"
    )
    @rental_movie = @movie.rentals.create(
      paid_price: 50,
    )
    @rental_serie = @serie.rentals.create(
      paid_price: 43,
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all rentals' do
      get :index
      rentals = JSON.parse(response.body)
      expect(rentals.size).to eq 2
    end
  end

  describe "POST create rental in movie" do
    it "returns http status created" do
      post :movie, params: {
        paid_price: @movie.price,
        id: @movie.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created rental" do
      post :movie, params: {
        paid_price: @movie.price,
        id: @movie.id
      }
      expected_rental = JSON.parse(response.body)
      expect(expected_rental).to have_key("id")
      expect(expected_rental["paid_price"]).to eq(@movie.price)
    end
  end

  describe "POST create rental in serie" do
    it "returns http status created" do
      post :serie, params: {
        paid_price: @serie.price,
        id: @serie.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created rental" do
      post :serie, params: {
        paid_price: @serie.price,
        id: @serie.id
      }
      expected_rental = JSON.parse(response.body)
      expect(expected_rental).to have_key("id")
      expect(expected_rental["paid_price"]).to eq(@serie.price)
    end
  end
end