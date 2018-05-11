Rails.application.routes.draw do

  get '/zomg', to: "customers#zomg"

  resources :movies, only: [:index, :show, :create]

  resources :customers, only: [ :index, :show, :create]

  resources :rentals, only: [:index, :show]

  post '/rentals/check-out', to: "rentals#create"

  post '/rentals/check-in', to: "rentals#update"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
