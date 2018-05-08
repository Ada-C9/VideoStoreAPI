Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies, only: [:index, :show, :create]

  get '/customers', to: 'customers#index', as: 'customers'

  post '/rentals/check-out', to: 'rentals#check_out', as: 'check_out'

  post '/rentals/check-in', to: 'rentals#check_in', as: 'check_in'
end
