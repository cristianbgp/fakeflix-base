require 'rails_helper'

describe Api::MoviesController do
  before do
    Movie.delete_all
    @movie = Movie.create(
      title: "Scott pilgrim vs the world",
      description: "Scott pilgrim se la pasa peleando con los ex de Ramona",
      rating: 0,
      price: 30,
      status: "billboard",
      playback: 20
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    
    it 'render json with all movies' do
      get :index
      movies = JSON.parse(response.body)
      expect(movies.size).to eq 1
    end

    it 'render json with all movies by filter' do
      other_movie = Movie.create(
        title: "Piratas de silicon valley",
        description: "Piratea y difunde",
        status: "preorder",
      )
      get :index, params: { filter: other_movie.status }
      movies = JSON.parse(response.body)
      expect(movies.size).to eq 1
      expect(movies[0]["status"]).to eq other_movie.status
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { id: @movie }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct @movie' do
        get :show, params: { id: @movie }
        expected_movie = JSON.parse(response.body)
        expect(expected_movie["id"]).to eq(@movie.id)
    end
  end

  describe "PATCH update playback" do
    it "returns http status ok in playback" do
      patch :playback, params: {
        id: @movie,
        progress: 80,
      }
      expect(response).to have_http_status(:ok)
    end
    
    it "returns the updated @movie" do
      patch :playback, params: {
        id: @movie,
        progress: 80,
      }
      expected_movie = JSON.parse(response.body)
      expect(expected_movie["playback"]).to eq(80)
    end
  end

  describe "PATCH update rating" do
    it "returns http status ok" do
      patch :rating, params: {
        id: @movie,
        rating: 3,
      }
      expect(response).to have_http_status(:ok)
    end
    
    it "returns the updated @movie" do
      patch :rating, params: {
        id: @movie,
        rating: 3
      }
      expected_movie = JSON.parse(response.body)
      expect(expected_movie["rating"]).to eq(3)
    end
  end
end