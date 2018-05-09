Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies, only: [:index, :show, :create]

  get '/customers', to: 'customers#index', as: 'customers'

  post '/rentals/checkout', to: 'rentals#check_out', as: 'check_out'

  patch '/rentals/checkin', to: 'rentals#check_in', as: 'check_in'
end
