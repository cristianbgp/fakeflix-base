Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :movies, only: [:index, :show] do
      member do
        put "playback"
        put "rating"
      end
    end

    resources :series, only: [ :index, :show ] do
      put "rating", on: :member
    end

    resources :episodes, only: [:show] do
      put "playback", on: :member    
    end
 
    resources :rentals, only: [:index, :show] do
      collection do
        post 'movies/:id' => :movie
        post 'series/:id' => :serie
      end
    end
  end
 end
