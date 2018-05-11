Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/movies', to: 'movies#index', as: 'movies'
  get '/movies/:id', to: 'movies#show', as: 'movie'
  post '/movies', to: 'movies#create', as: 'add_movie'

  get '/customers', to: 'customers#index', as: 'customers'

  post '/rentals/check-out', to: 'rentals#checkout', as: 'checkout'

  post '/rentals/check-in', to: 'rentals#checkin', as: 'checkin'
end
