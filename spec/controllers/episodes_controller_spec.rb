require 'rails_helper'

describe Api::EpisodesController do

  before do
    @serie = Serie.create(
      title: "Black Mirror",
      description: "Una serie de capitulos bien raros",
      rating: 0,
      price: 30,
      status: "billboard"
    )
    @episode = @serie.episodes.create(
      title: "Something",
      description: "Resulta que un alumno de un bootcamp crea un programa inteligente que empieza a matar a todos",
      duration: 49,
      playback: 300
    )
  end

  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { id: @episode }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct episode' do
      get :show, params: { id: @episode }
      expected_episode = JSON.parse(response.body)
      expect(expected_episode["id"]).to eq(@episode.id)
    end
  end

  describe "PATCH update" do
    it "returns http status ok in playback" do
      patch :playback, params: {
        id: @episode,
        progress: 80,
      }
      expect(response).to have_http_status(:ok)
    end
    
    it "returns the updated playback" do
      patch :playback, params: {
        id: @episode,
        progress: 80,
      }
      expected_episode = JSON.parse(response.body)
      expect(expected_episode["playback"]).to eq(80)
    end
  end

end