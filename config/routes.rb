Rails.application.routes.draw do

  get '/customers', to: 'customers#index', as: 'customers'
  get '/movies', to: 'movies#index', as: 'movies'
  get '/movie/:id', to: 'movies#show', as: 'movie'

  post '/movies', to: 'movies#create', as: 'new_movie'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
