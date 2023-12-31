Rails.application.routes.draw do
  get 'checkcard/index'
  get 'reviews/index'
  get 'reviews/show'

  devise_for :users

  root "pages#home"

  resources :journeys, only: [:create, :update, :show] do
    resources :places, only: [:index, :show] do
      get 'nearby_restaurants', to: 'places#nearby_restaurants', on: :member
      get 'nearby_bars', to: 'places#nearby_bars', on: :member
    end
    resources :visits, only: [:create, :destroy] do
      resources :reviews, only: [:create]
    end
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
