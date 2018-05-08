Rails.application.routes.draw do

  get '/customers', to: 'customers#index', as: 'customers'

  get '/movies', to: 'movies#index', as: 'movies'

  post '/movies', to: 'movies#create'

  get '/movies/:id', to: 'movies#show', as: 'movie'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
