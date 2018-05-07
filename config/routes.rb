Rails.application.routes.draw do
  post 'rentals/checkout', to: 'rentals#checkout', as: :checkout

  post 'rentals/checkin', to: 'rentals#checkin', as: :checkin

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/zomg', to: 'movies#zomg'
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show]
end
