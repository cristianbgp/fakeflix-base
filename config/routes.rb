Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/login', to: 'sessions#create'
  namespace :api do
    resources :movies, only: [:index, :show] do
      member do
        patch "playback"
        patch "rating"
      end
    end

    resources :series, only: [ :index, :show ] do
      patch "rating", on: :member
    end

    resources :episodes, only: [:show] do
      patch "playback", on: :member    
    end
 
    resources :rentals, only: [:index, :show] do
      collection do
        post 'movies/:id' => :movie
        post 'series/:id' => :serie
      end
    end
  end
 end
